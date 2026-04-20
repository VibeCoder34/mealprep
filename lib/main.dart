import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
import 'settings_controller.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );
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
  final SettingsController _settings = SettingsController();

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
        return ListenableBuilder(
          listenable: _settings,
          builder: (context, _) {
            return MaterialApp(
              onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
              debugShowCheckedModeBanner: false,
              locale: _localeController.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              theme: AppTheme.light(),
              darkTheme: AppTheme.dark(),
              themeMode: _settings.themeMode,
              home: AppRoot(
                localeController: _localeController,
                session: _session,
                settings: _settings,
              ),
            );
          },
        );
      },
    );
  }

  // Theme lives in `lib/theme/app_theme.dart`.
}

// ─── Auth + onboarding gate ─────────────────────────────────────────────────

class AppRoot extends StatefulWidget {
  final LocaleController localeController;
  final SessionController session;
  final SettingsController settings;

  const AppRoot({
    super.key,
    required this.localeController,
    required this.session,
    required this.settings,
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
          return const AuthScreen();
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
          settings: widget.settings,
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
  final SettingsController settings;
  final Future<void> Function() onLogout;

  const MainScaffold({
    super.key,
    required this.localeController,
    required this.session,
    required this.settings,
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
        settings: widget.settings,
        session: widget.session,
        onLogout: widget.onLogout,
      ),
    ];

    return ListenableBuilder(
      listenable: _appState,
      builder: (context, _) {
        final isSyncing = _appState.isSyncingBackend;
        final syncError = _appState.lastBackendSyncError;
        final colorScheme = Theme.of(context).colorScheme;
        final maxBannerWidth = MediaQuery.sizeOf(context).width - 24;

        return Stack(
          children: [
            Scaffold(
              body: IndexedStack(
                index: _currentIndex,
                children: screens,
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.outline.withValues(alpha: Theme.of(context).brightness == Brightness.dark ? 0.6 : 0.35),
                      width: 1,
                    ),
                  ),
                ),
                child: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  onTap: _navigateToTab,
                  backgroundColor: colorScheme.surface,
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
            ),
            if (isSyncing)
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: AnimatedOpacity(
                    opacity: 1,
                    duration: const Duration(milliseconds: 150),
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.05),
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.only(top: 48),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x22000000),
                              blurRadius: 14,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: maxBannerWidth),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  'Yükleniyor...',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (!isSyncing && syncError != null)
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Material(
                      elevation: 6,
                      borderRadius: BorderRadius.circular(14),
                      color: Theme.of(context).colorScheme.surface,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: maxBannerWidth),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.wifi_off_rounded, color: Theme.of(context).colorScheme.error),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  syncError,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: () => _appState.refreshFromBackend(),
                                child: const Text('Tekrar Dene'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
