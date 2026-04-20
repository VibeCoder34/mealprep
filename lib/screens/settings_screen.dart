import 'package:flutter/material.dart';
import '../app_state.dart';
import '../locale_controller.dart';
import '../l10n/app_localizations.dart';
import '../models/diet_keys.dart';
import '../session_controller.dart';
import '../settings_controller.dart';
import '../widgets/premium_feature_modal.dart';

class SettingsScreen extends StatelessWidget {
  final AppState appState;
  final LocaleController localeController;
  final SettingsController settings;
  final SessionController session;
  final Future<void> Function() onLogout;

  const SettingsScreen({
    super.key,
    required this.appState,
    required this.localeController,
    required this.settings,
    required this.session,
    required this.onLogout,
  });

  String _languageDisplayName(AppLocalizations l10n, String code) {
    switch (code) {
      case 'es':
        return l10n.langSpanish;
      case 'tr':
        return l10n.langTurkish;
      case 'en':
      default:
        return l10n.langEnglish;
    }
  }

  void _showLanguageSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    l10n.language,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ),
                RadioListTile<String>(
                  title: Text(l10n.langEnglish),
                  value: 'en',
                  groupValue: localeController.locale.languageCode,
                  activeColor: const Color(0xFF00ACC1),
                  onChanged: (v) async {
                    if (v == null) return;
                    await localeController.setLocale(Locale(v));
                    if (ctx.mounted) Navigator.of(ctx).pop();
                  },
                ),
                RadioListTile<String>(
                  title: Text(l10n.langSpanish),
                  value: 'es',
                  groupValue: localeController.locale.languageCode,
                  activeColor: const Color(0xFF00ACC1),
                  onChanged: (v) async {
                    if (v == null) return;
                    await localeController.setLocale(Locale(v));
                    if (ctx.mounted) Navigator.of(ctx).pop();
                  },
                ),
                RadioListTile<String>(
                  title: Text(l10n.langTurkish),
                  value: 'tr',
                  groupValue: localeController.locale.languageCode,
                  activeColor: const Color(0xFF00ACC1),
                  onChanged: (v) async {
                    if (v == null) return;
                    await localeController.setLocale(Locale(v));
                    if (ctx.mounted) Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _onDietToggle(
    BuildContext context,
    String key,
  ) async {
    final ok = await appState.toggleDietaryPreference(key);
    if (!ok && context.mounted) {
      await showPremiumFilterLimitModal(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        return ListenableBuilder(
          listenable: session,
          builder: (context, _) {
            return ListenableBuilder(
              listenable: settings,
              builder: (context, _) {
                return Scaffold(
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 1,
            surfaceTintColor: Colors.transparent,
            title: Text(
              l10n.settingsTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProfileCard(
                  isPremium: appState.isPremium,
                  userName: session.userName.isEmpty ? l10n.userLabel : session.userName,
                  userEmail: session.userEmail.isEmpty ? '—' : session.userEmail,
                  l10n: l10n,
                ),
                const SizedBox(height: 20),
                if (!appState.isPremium) ...[
                  _UpgradeCard(
                    l10n: l10n,
                    onUpgrade: () => _showUpgradeDialog(context, l10n),
                  ),
                  const SizedBox(height: 20),
                ] else ...[
                  _PremiumBadge(l10n: l10n),
                  const SizedBox(height: 20),
                ],
                _SectionHeader(l10n.sectionFeatures),
                const SizedBox(height: 10),
                _FeaturesList(
                  isPremium: appState.isPremium,
                  l10n: l10n,
                  appState: appState,
                ),
                const SizedBox(height: 20),
                _SectionHeader(l10n.sectionGeneral),
                const SizedBox(height: 10),
                _SettingsGroup(
                  children: [
                    _SettingsTile(
                      icon: Icons.language_rounded,
                      iconColor: const Color(0xFF42A5F5),
                      title: l10n.language,
                      onTap: () => _showLanguageSheet(context),
                      trailing: Text(
                        _languageDisplayName(
                            l10n, localeController.locale.languageCode),
                        style: const TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    _SettingsTile(
                      icon: Icons.notifications_outlined,
                      iconColor: const Color(0xFFFF7043),
                      title: l10n.notifications,
                      trailing: Switch(
                        value: settings.notificationsEnabled,
                        onChanged: (v) => settings.setNotificationsEnabled(v),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    _SettingsTile(
                      icon: Icons.dark_mode_outlined,
                      iconColor: const Color(0xFF7E57C2),
                      title: l10n.darkMode,
                      trailing: Switch(
                        value: settings.darkModeEnabled,
                        onChanged: (v) => settings.setDarkModeEnabled(v),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _SectionHeader(l10n.dietaryPreferencesTitle),
                const SizedBox(height: 10),
                _SettingsGroup(
                  children: [
                    _DietPrefTile(
                      label: l10n.dietHighProtein,
                      selected: appState.hasDietaryPreference(DietKeys.highProtein),
                      onChanged: (v) => _onDietToggle(context, DietKeys.highProtein),
                    ),
                    _DietPrefTile(
                      label: l10n.dietLowCarb,
                      selected: appState.hasDietaryPreference(DietKeys.lowCarb),
                      onChanged: (v) => _onDietToggle(context, DietKeys.lowCarb),
                    ),
                    _DietPrefTile(
                      label: l10n.dietVegan,
                      selected: appState.hasDietaryPreference(DietKeys.vegan),
                      onChanged: (v) => _onDietToggle(context, DietKeys.vegan),
                    ),
                    _DietPrefTile(
                      label: l10n.dietVegetarian,
                      selected: appState.hasDietaryPreference(DietKeys.vegetarian),
                      onChanged: (v) => _onDietToggle(context, DietKeys.vegetarian),
                    ),
                    _DietPrefTile(
                      label: l10n.dietKeto,
                      selected: appState.hasDietaryPreference(DietKeys.keto),
                      onChanged: (v) => _onDietToggle(context, DietKeys.keto),
                    ),
                    _DietPrefTile(
                      label: l10n.dietGlutenFree,
                      selected: appState.hasDietaryPreference(DietKeys.glutenFree),
                      onChanged: (v) => _onDietToggle(context, DietKeys.glutenFree),
                    ),
                    _DietPrefTile(
                      label: l10n.dietHalal,
                      selected: appState.hasDietaryPreference(DietKeys.halal),
                      onChanged: (v) => _onDietToggle(context, DietKeys.halal),
                    ),
                    _DietPrefTile(
                      label: l10n.dietNoDairy,
                      selected: appState.hasDietaryPreference(DietKeys.noDairy),
                      onChanged: (v) => _onDietToggle(context, DietKeys.noDairy),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _SectionHeader(l10n.sectionAbout),
                const SizedBox(height: 10),
                _SettingsGroup(
                  children: [
                    _SettingsTile(
                      icon: Icons.star_outline_rounded,
                      iconColor: const Color(0xFFFFCA28),
                      title: l10n.rateApp,
                      showChevron: true,
                    ),
                    _SettingsTile(
                      icon: Icons.share_outlined,
                      iconColor: const Color(0xFF66BB6A),
                      title: l10n.shareFriends,
                      showChevron: true,
                    ),
                    _SettingsTile(
                      icon: Icons.info_outline_rounded,
                      iconColor: const Color(0xFF78909C),
                      title: l10n.version,
                      trailing: const Text(
                        '1.0.0',
                        style: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    _SettingsTile(
                      icon: Icons.logout_rounded,
                      iconColor: const Color(0xFFE53935),
                      title: l10n.logout,
                      onTap: () => onLogout(),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
            );
              },
            );
          },
        );
      },
    );
  }

  void _showUpgradeDialog(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _UpgradeSheet(
        l10n: l10n,
        onConfirm: () async {
          Navigator.of(context).pop();
          await appState.upgradeToPremium();
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.upgradedPremium),
              backgroundColor: const Color(0xFF00ACC1),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.all(16),
            ),
          );
        },
      ),
    );
  }
}

class _DietPrefTile extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onChanged;

  const _DietPrefTile({
    required this.label,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: selected,
      onChanged: (v) => onChanged(v ?? false),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1A1A2E),
        ),
      ),
      controlAffinity: ListTileControlAffinity.trailing,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14),
      activeColor: const Color(0xFF00ACC1),
      checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final bool isPremium;
  final String userName;
  final String userEmail;
  final AppLocalizations l10n;

  const _ProfileCard({
    required this.isPremium,
    required this.userName,
    required this.userEmail,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final initial =
        userName.isNotEmpty ? userName[0].toUpperCase() : '?';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00ACC1), Color(0xFF00838F)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                initial,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  userEmail,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9E9E9E),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isPremium
                        ? const Color(0xFFFFF3E0)
                        : const Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isPremium ? l10n.premiumPlan : l10n.freeTierBadge,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isPremium
                          ? const Color(0xFFE65100)
                          : const Color(0xFF9E9E9E),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UpgradeCard extends StatelessWidget {
  final VoidCallback onUpgrade;
  final AppLocalizations l10n;

  const _UpgradeCard({required this.onUpgrade, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00ACC1), Color(0xFF00838F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('⭐', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              Text(
                l10n.goPremium,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  l10n.premiumPrice,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.95),
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _bullet(l10n.premiumBullet1),
          _bullet(l10n.premiumBullet2),
          _bullet(l10n.premiumBullet3),
          _bullet(l10n.premiumBullet4),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onUpgrade,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF00ACC1),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              child: Text(l10n.tryFree7Days),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bullet(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            const Icon(Icons.check_circle_rounded,
                size: 15, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 13.5,
                ),
              ),
            ),
          ],
        ),
      );
}

class _PremiumBadge extends StatelessWidget {
  final AppLocalizations l10n;

  const _PremiumBadge({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFFE082)),
      ),
      child: Row(
        children: [
          const Text('🎉', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.premiumMemberTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.premiumMemberSubtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.verified_rounded,
              color: Color(0xFFFFCA28), size: 28),
        ],
      ),
    );
  }
}

class _FeaturesList extends StatelessWidget {
  final bool isPremium;
  final AppLocalizations l10n;
  final AppState appState;

  const _FeaturesList({
    required this.isPremium,
    required this.l10n,
    required this.appState,
  });

  @override
  Widget build(BuildContext context) {
    final features = <(
      String name,
      IconData icon,
      bool freeUnlock,
      Color color,
      Future<void> Function()? onLockedTap
    )>[
      (l10n.featInventory, Icons.kitchen_rounded, true, const Color(0xFF42A5F5), null),
      (l10n.featRecipes, Icons.menu_book_rounded, true, const Color(0xFF66BB6A), null),
      (l10n.featShopping, Icons.shopping_cart_rounded, true, const Color(0xFFFF7043), null),
      (
        l10n.featAiRecipeCreate,
        Icons.auto_awesome_rounded,
        false,
        const Color(0xFF7E57C2),
        () => showPremiumFeatureModal(
          context,
          appState: appState,
          description: l10n.premiumFeatureDefaultBody,
        )
      ),
      (
        l10n.featMacroOptimize,
        Icons.balance_rounded,
        false,
        const Color(0xFF00838F),
        () => showPremiumFeatureModal(
          context,
          appState: appState,
          description: l10n.premiumFeatureDefaultBody,
        )
      ),
      (
        l10n.featWeeklyMealPlan,
        Icons.calendar_month_rounded,
        false,
        const Color(0xFFFFCA28),
        () => showPremiumFeatureModal(
          context,
          appState: appState,
          description: l10n.premiumFeatureDefaultBody,
        )
      ),
      (
        l10n.featNutritionAnalysis,
        Icons.monitor_heart_rounded,
        false,
        const Color(0xFFEF5350),
        () => showPremiumFeatureModal(
          context,
          appState: appState,
          description: l10n.premiumFeatureDefaultBody,
        )
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        children: features.asMap().entries.map((entry) {
          final idx = entry.key;
          final f = entry.value;
          final name = f.$1;
          final icon = f.$2;
          final freeUnlock = f.$3;
          final color = f.$4;
          final onLockedTap = f.$5;
          final isAvailable = isPremium || freeUnlock;
          final isLast = idx == features.length - 1;

          return Column(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: !isAvailable && onLockedTap != null
                      ? () => onLockedTap()
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(icon, size: 18, color: color),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                              color: isAvailable
                                  ? const Color(0xFF1A1A2E)
                                  : const Color(0xFFBDBDBD),
                            ),
                          ),
                        ),
                        if (!freeUnlock)
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3E0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              l10n.proBadge,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFE65100),
                              ),
                            ),
                          ),
                        Icon(
                          isAvailable
                              ? Icons.check_circle_rounded
                              : Icons.lock_outline_rounded,
                          size: 20,
                          color: isAvailable
                              ? const Color(0xFF66BB6A)
                              : const Color(0xFFBDBDBD),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (!isLast)
                const Divider(
                    height: 1,
                    indent: 64,
                    endIndent: 16,
                    color: Color(0xFFF5F5F5)),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF9E9E9E),
        letterSpacing: 0.5,
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final List<Widget> children;
  const _SettingsGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        children: children.asMap().entries.map((e) {
          final isLast = e.key == children.length - 1;
          return Column(
            children: [
              e.value,
              if (!isLast)
                const Divider(
                    height: 1,
                    indent: 64,
                    endIndent: 16,
                    color: Color(0xFFF5F5F5)),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget? trailing;
  final bool showChevron;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.trailing,
    this.showChevron = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ),
            if (trailing != null) trailing!,
            if (showChevron)
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFFCCCCCC),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}

class _UpgradeSheet extends StatelessWidget {
  final VoidCallback onConfirm;
  final AppLocalizations l10n;

  const _UpgradeSheet({required this.onConfirm, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('⭐', style: TextStyle(fontSize: 52)),
            const SizedBox(height: 14),
            Text(
              l10n.upgradeSheetTitle,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.upgradeSheetSubtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF9E9E9E),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onConfirm,
                child: Text(l10n.upgradeSheetCta),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                l10n.notNow,
                style: const TextStyle(color: Color(0xFF9E9E9E)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
