import 'package:flutter/material.dart';
import '../app_state.dart';
import '../l10n/app_localizations.dart';

/// Premium upsell dialog used across the app (mock purchase).
Future<void> showPremiumFeatureModal(
  BuildContext context, {
  required AppState appState,
  String? description,
}) async {
  final l10n = AppLocalizations.of(context)!;
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(ctx).bottom,
        ),
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('⭐', style: TextStyle(fontSize: 44)),
                const SizedBox(height: 12),
                Text(
                  l10n.premiumFeatureTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A2E),
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description ?? l10n.premiumFeatureDefaultBody,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14.5,
                    color: Color(0xFF9E9E9E),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      _showUpgradeSheet(context, appState, l10n);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1976D2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      l10n.upgradeToPremiumCta,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(
                    l10n.notNow,
                    style: const TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void _showUpgradeSheet(
  BuildContext context,
  AppState appState,
  AppLocalizations l10n,
) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => Container(
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
            Text(
              l10n.upgradeSheetTitle,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
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
                onPressed: () {
                  appState.upgradeToPremium();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.upgradedPremium),
                      backgroundColor: const Color(0xFF00ACC1),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.all(16),
                    ),
                  );
                },
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
    ),
  );
}

Future<void> showPremiumFilterLimitModal(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _SimplePremiumSheet(
      title: l10n.premiumUnlimitedFiltersTitle,
      body: l10n.premiumUnlimitedFiltersBody,
      onNotNow: () => Navigator.of(ctx).pop(),
    ),
  );
}

Future<void> showPremiumSavedLimitModal(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _SimplePremiumSheet(
      title: l10n.premiumUnlimitedSavedTitle,
      body: l10n.premiumUnlimitedSavedBody,
      onNotNow: () => Navigator.of(ctx).pop(),
    ),
  );
}

class _SimplePremiumSheet extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback onNotNow;

  const _SimplePremiumSheet({
    required this.title,
    required this.body,
    required this.onNotNow,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              body,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF9E9E9E),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onNotNow,
                child: Text(l10n.done),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
