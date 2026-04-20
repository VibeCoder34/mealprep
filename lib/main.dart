import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_state.dart';
import 'locale_controller.dart';
import 'l10n/app_localizations.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/recipe_screen.dart';
import 'screens/shopping_list_screen.dart';
import 'screens/settings_screen.dart';
import 'session_controller.dart';

void main() {
  runApp(const MealPrepApp());
}

class MealPrepApp extends StatefulWidget {
  const MealPrepApp({super.key});

  @override
  State<MealPrepApp> createState() => _MealPrepAppState();
}

class _MealPrepAppState extends State<MealPrepApp> {
  final LocaleController _localeController = LocaleController();
  final SessionController _session = SessionController();

  @override
  void initState() {
    super.initState();
    _session.load().then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _localeController,
      builder: (context, _) {
        return MaterialApp(
          onGenerateTitle: (context) =>
              AppLocalizations.of(context)!.appTitle,
          debugShowCheckedModeBanner: false,
          locale: _localeController.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          theme: _buildTheme(),
          home: AppRoot(
            localeController: _localeController,
            session: _session,
          ),
        );
      },
    );
  }

  ThemeData _buildTheme() {
    const primaryColor = Color(0xFF00ACC1);
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        primary: primaryColor,
      ),
      scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        iconTheme: IconThemeData(color: Color(0xFF1A1A2E)),
        titleTextStyle: TextStyle(
          color: Color(0xFF1A1A2E),
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: Color(0xFFBDBDBD),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }
}

// ─── Auth + onboarding gate ─────────────────────────────────────────────────

class AppRoot extends StatefulWidget {
  final LocaleController localeController;
  final SessionController session;

  const AppRoot({
    super.key,
    required this.localeController,
    required this.session,
  });

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.session,
      builder: (context, _) {
        final s = widget.session;
        if (!s.isReady) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!s.isLoggedIn) {
          return AuthScreen(
            onAuthenticated: ({required email, required name}) async {
              await s.authenticate(email: email, name: name);
            },
          );
        }

        if (!s.onboardingDone) {
          return OnboardingScreen(
            onDone: () async {
              await s.completeOnboarding();
            },
          );
        }

        return MainScaffold(
          localeController: widget.localeController,
          session: s,
          onLogout: () async {
            await s.logout();
          },
        );
      },
    );
  }
}

// ─── Main navigation scaffold ───────────────────────────────────────────────

class MainScaffold extends StatefulWidget {
  final LocaleController localeController;
  final SessionController session;
  final Future<void> Function() onLogout;

  const MainScaffold({
    super.key,
    required this.localeController,
    required this.session,
    required this.onLogout,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;
  late final AppState _appState;

  @override
  void initState() {
    super.initState();
    _appState = AppState();
  }

  void _navigateToTab(int index) => setState(() => _currentIndex = index);

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final screens = [
      HomeScreen(appState: _appState),
      RecipeScreen(appState: _appState),
      ShoppingListScreen(
        appState: _appState,
        onGoToRecipes: () => _navigateToTab(1),
      ),
      SettingsScreen(
        appState: _appState,
        localeController: widget.localeController,
        session: widget.session,
        onLogout: widget.onLogout,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFF0F0F0), width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _navigateToTab,
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.kitchen_outlined),
              activeIcon: const Icon(Icons.kitchen_rounded),
              label: l10n.navPantry,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.menu_book_outlined),
              activeIcon: const Icon(Icons.menu_book_rounded),
              label: l10n.navRecipes,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart_outlined),
              activeIcon: const Icon(Icons.shopping_cart_rounded),
              label: l10n.navShopping,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings_outlined),
              activeIcon: const Icon(Icons.settings_rounded),
              label: l10n.navSettings,
            ),
          ],
        ),
      ),
    );
  }
}
