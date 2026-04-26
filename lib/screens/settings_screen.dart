import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../l10n/app_localizations.dart';
import '../models/settings_models.dart';
import '../providers/settings_provider.dart';
import '../services/settings_service.dart';
import '../session_controller.dart';
import '../settings_controller.dart';

class SettingsScreen extends StatefulWidget {
  final AppState appState;
  final SettingsController settings;
  final SessionController session;
  final Future<void> Function() onLogout;

  const SettingsScreen({
    super.key,
    required this.appState,
    required this.settings,
    required this.session,
    required this.onLogout,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final SettingsProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = SettingsProvider(service: SettingsService.instance);
    WidgetsBinding.instance.addPostFrameCallback((_) => _provider.load());
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  void _toast(String msg, {Color? bg}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: bg,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Future<void> _showEditProfileDialog(UserProfile profile) async {
    final nameController = TextEditingController(text: profile.fullName);
    final formKey = GlobalKey<FormState>();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return ChangeNotifierProvider.value(
          value: _provider,
          child: AlertDialog(
            title: const Text('Profili Düzenle'),
            content: Form(
              key: formKey,
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Ad Soyad',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.done,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Ad Soyad gerekli';
                  return null;
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('İptal'),
              ),
              Consumer<SettingsProvider>(
                builder: (context, p, _) {
                  return FilledButton(
                    onPressed: p.savingProfile
                        ? null
                        : () async {
                            if (!(formKey.currentState?.validate() ?? false)) return;
                            try {
                              await p.updateProfile(fullName: nameController.text);
                              if (dialogContext.mounted) Navigator.of(dialogContext).pop();
                              _toast('Kaydedildi', bg: const Color(0xFF00ACC1));
                            } catch (e) {
                              _toast(e.toString());
                            }
                          },
                    child: p.savingProfile
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Kaydet'),
                  );
                },
              ),
            ],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          ),
        );
      },
    );
  }

  Future<void> _confirmLogout() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Çıkış Yap'),
        content: const Text('Çıkış yapmak istediğine emin misin?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('İptal')),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Evet, Çıkış Yap'),
          ),
        ],
      ),
    );

    if (ok != true) return;

    try {
      await _provider.logout();
      await widget.onLogout();
    } catch (_) {
      _toast('Çıkış yapılamadı, lütfen tekrar deneyin');
    }
  }

  Future<void> _showPremiumSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return ChangeNotifierProvider.value(
          value: _provider,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(ctx).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Premium', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 12),
                    const Text(
                      "Şu anda Supabase'de premium status store'lanıyor, payment logic sonra eklenecek",
                      style: TextStyle(color: Color(0xFF757575)),
                    ),
                    const SizedBox(height: 16),
                    _PlanTile(
                      title: r'$4.99 / Ay',
                      subtitle: 'Aylık plan',
                      onTap: () async {
                        try {
                          await ctx.read<SettingsProvider>().mockBuyPremiumMonthly();
                          if (ctx.mounted) Navigator.of(ctx).pop();
                          _toast('Kaydedildi', bg: const Color(0xFF00ACC1));
                        } catch (e) {
                          _toast(e.toString());
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    _PlanTile(
                      title: r'$39.99 / Yıl',
                      subtitle: 'Yıllık plan',
                      onTap: () async {
                        try {
                          await ctx.read<SettingsProvider>().mockBuyPremiumYearly();
                          if (ctx.mounted) Navigator.of(ctx).pop();
                          _toast('Kaydedildi', bg: const Color(0xFF00ACC1));
                        } catch (e) {
                          _toast(e.toString());
                        }
                      },
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {},
                        child: const Text("Premium'ı Satın Al"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Consumer<SettingsProvider>(
        builder: (context, p, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(l10n.settingsTitle),
              scrolledUnderElevation: 1,
            ),
            body: p.isLoading
                ? const Center(child: CircularProgressIndicator())
                : p.error != null
                    ? _ErrorState(message: p.error!, onRetry: () => p.load())
                    : RefreshIndicator(
                        onRefresh: () => p.load(),
                        child: ListView(
                          padding: const EdgeInsets.all(16),
                          children: [
                            _SectionTitle('Profil'),
                            const SizedBox(height: 10),
                            _Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.email_outlined),
                                    title: const Text('E-posta'),
                                    subtitle: Text(p.profile?.email ?? '—'),
                                  ),
                                  const Divider(height: 1),
                                  ListTile(
                                    leading: const Icon(Icons.person_outline),
                                    title: const Text('Ad Soyad'),
                                    subtitle: Text((p.profile?.fullName ?? '').isEmpty ? '—' : p.profile!.fullName),
                                    trailing: TextButton(
                                      onPressed: p.profile == null ? null : () => _showEditProfileDialog(p.profile!),
                                      child: const Text('Profili Düzenle'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            _SectionTitle('Beslenme Tercihleri'),
                            const SizedBox(height: 10),
                            _Card(
                              child: Column(
                                children: [
                                  const _DietTile(label: 'Vegan', value: 'vegan'),
                                  const _DietTile(label: 'Vejetaryen', value: 'vegetarian'),
                                  const _DietTile(label: 'Keto', value: 'keto'),
                                  const _DietTile(label: 'Glutensiz', value: 'gluten_free'),
                                  const _DietTile(label: 'Halal', value: 'halal'),
                                  const _DietTile(label: 'Sütü Seçme', value: 'no_dairy', isLast: true),
                                  if (p.savingDietary)
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(16, 8, 16, 14),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
                                          SizedBox(width: 10),
                                          Text('Kaydediliyor...'),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            _SectionTitle('Uygulama Ayarları'),
                            const SizedBox(height: 10),
                            _Card(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.brightness_6_outlined,
                                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Tema', style: Theme.of(context).textTheme.titleMedium),
                                                  const SizedBox(height: 2),
                                                  Text(
                                                    switch (p.themeMode) {
                                                      ThemeMode.system => 'Sistem Teması',
                                                      ThemeMode.light => 'Aydınlık Tema',
                                                      ThemeMode.dark => 'Koyu Tema',
                                                    },
                                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 14),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: SegmentedButton<ThemeMode>(
                                            segments: const [
                                              ButtonSegment(value: ThemeMode.system, label: Text('Sistem')),
                                              ButtonSegment(value: ThemeMode.light, label: Text('Aydınlık')),
                                              ButtonSegment(value: ThemeMode.dark, label: Text('Koyu')),
                                            ],
                                            selected: {p.themeMode},
                                            onSelectionChanged: (s) async {
                                              final mode = s.first;
                                              await p.setThemeMode(mode);
                                              await widget.settings.setThemeMode(mode);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(height: 1),
                                  SwitchListTile(
                                    secondary: const Icon(Icons.notifications_outlined),
                                    title: const Text('Bildirimler'),
                                    value: p.notificationsEnabled,
                                    onChanged: (v) async {
                                      await p.setNotificationsEnabled(v);
                                      await widget.settings.setNotificationsEnabled(v);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            _SectionTitle('Premium'),
                            const SizedBox(height: 10),
                            _Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        _Badge(
                                          text: p.premiumStatus.isPremium ? 'Premium' : 'Bedava',
                                          color: p.premiumStatus.isPremium ? const Color(0xFFFFE082) : const Color(0xFFE0E0E0),
                                          textColor: p.premiumStatus.isPremium ? const Color(0xFFE65100) : const Color(0xFF616161),
                                        ),
                                        const Spacer(),
                                        if (!p.premiumStatus.isPremium)
                                          FilledButton(
                                            onPressed: _showPremiumSheet,
                                            child: const Text("Premium'a Yükselt"),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    const _Benefit('✅ Sınırsız yaratıcı tarifler'),
                                    const _Benefit('✅ Sınırsız beslenme filtreleri'),
                                    const _Benefit('✅ Haftalık yemek planı'),
                                    const _Benefit('✅ Makro optimizasyonu'),
                                    const _Benefit('✅ Beslenme analizi'),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            _SectionTitle('Çıkış'),
                            const SizedBox(height: 10),
                            _Card(
                              child: ListTile(
                                leading: const Icon(Icons.logout_rounded, color: Colors.red),
                                title: const Text('Çıkış Yap', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700)),
                                subtitle: const Text('Hesabından çıkış yap'),
                                onTap: _confirmLogout,
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
          );
        },
      ),
    );
  }
}

class _DietTile extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;
  const _DietTile({required this.label, required this.value, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<SettingsProvider>();
    final selected = p.hasDietPref(value);
    return Column(
      children: [
        CheckboxListTile(
          value: selected,
          onChanged: (_) async {
            try {
              await context.read<SettingsProvider>().toggleDietPref(value);
            } catch (_) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bağlantı hatası, lütfen tekrar deneyin')),
              );
            }
          },
          title: Text(label),
          controlAffinity: ListTileControlAffinity.trailing,
        ),
        if (!isLast) const Divider(height: 1),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF757575)),
      );
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.15)),
      ),
      child: child,
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  const _Badge({required this.text, required this.color, required this.textColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
    );
  }
}

class _Benefit extends StatelessWidget {
  final String text;
  const _Benefit(this.text);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text, style: const TextStyle(fontSize: 14)),
      );
}

class _PlanTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _PlanTile({required this.title, required this.subtitle, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.25)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(color: Color(0xFF757575))),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorState({required this.message, required this.onRetry});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off_rounded, size: 40),
            const SizedBox(height: 10),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 14),
            FilledButton(onPressed: onRetry, child: const Text('Tekrar Dene')),
          ],
        ),
      ),
    );
  }
}

