import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/supabase_service.dart';
import 'terms_placeholder_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  static const _primary = Color(0xFF00ACC1);
  static const _text = Color(0xFF1A1A2E);
  static const _muted = Color(0xFF9E9E9E);

  final _fullName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  bool _isSignUp = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _termsAccepted = false;
  bool _submitting = false;

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _primary, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      labelStyle: const TextStyle(
        color: _muted,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating),
    );
  }

  Future<void> _submit(AppLocalizations l10n) async {
    if (_submitting) return;

    final email = _email.text.trim();
    final password = _password.text;
    final confirm = _confirm.text;
    final fullName = _fullName.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      _showError('Geçersiz email adresi');
      return;
    }
    if (password.length < 6) {
      _showError('Şifre en az 6 karakter olmalı');
      return;
    }
    if (_isSignUp && !_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.authTermsAgree),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if (_isSignUp && confirm != password) {
      _showError('Şifreler eşleşmiyor');
      return;
    }
    setState(() => _submitting = true);
    try {
      if (_isSignUp) {
        final res = await SupabaseService.instance.signUpWithEmail(
          email: email,
          password: password,
          fullName: fullName.isEmpty ? null : fullName,
        );
        final user = res.user;
        if (user != null) {
          await SupabaseService.instance.upsertUserProfile(
            userId: user.id,
            email: user.email ?? email,
            fullName: fullName.isEmpty ? null : fullName,
          );
        }
      } else {
        await SupabaseService.instance.signInWithEmail(
          email: email,
          password: password,
        );
      }
    } on FriendlyAuthException catch (e) {
      _showError(e.message);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _forgotPassword(AppLocalizations l10n) async {
    if (_submitting) return;
    final controller = TextEditingController(text: _email.text.trim());
    final email = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.authForgotPassword),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: _fieldDecoration(l10n.authEmail),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(null),
            child: const Text('İptal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
            child: const Text('Gönder'),
          ),
        ],
      ),
    ).whenComplete(controller.dispose);
    if (email == null || email.isEmpty) return;
    if (!mounted) return;
    setState(() => _submitting = true);
    try {
      await SupabaseService.instance.resetPasswordForEmail(email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Şifre sıfırlama bağlantısı email adresinize gönderildi'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } on FriendlyAuthException catch (e) {
      if (!mounted) return;
      _showError(e.message);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00ACC1), Color(0xFF00838F)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: _primary.withValues(alpha: 0.35),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text('🥗', style: TextStyle(fontSize: 36)),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                _isSignUp ? l10n.authHeadlineSignUp : l10n.authHeadlineSignIn,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: _text,
                  letterSpacing: -0.6,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _isSignUp ? l10n.authSubSignUp : l10n.authSubSignIn,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: _muted,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 26),
              _ModeToggle(
                isSignUp: _isSignUp,
                l10n: l10n,
                onChanged: (v) => setState(() {
                  _isSignUp = v;
                  if (!v) _confirm.clear();
                }),
              ),
              const SizedBox(height: 22),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFF0F0F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_isSignUp) ...[
                      TextField(
                        controller: _fullName,
                        textInputAction: TextInputAction.next,
                        decoration: _fieldDecoration(l10n.authFullName),
                      ),
                      const SizedBox(height: 14),
                    ],
                    TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      decoration: _fieldDecoration(l10n.authEmail),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _password,
                      obscureText: _obscurePassword,
                      textInputAction:
                          _isSignUp ? TextInputAction.next : TextInputAction.done,
                      decoration: _fieldDecoration(l10n.authPassword).copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: _muted,
                            size: 22,
                          ),
                          onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                    ),
                    if (_isSignUp) ...[
                      const SizedBox(height: 14),
                      TextField(
                        controller: _confirm,
                        obscureText: _obscureConfirm,
                        textInputAction: TextInputAction.done,
                        decoration:
                            _fieldDecoration(l10n.authConfirmPassword).copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirm
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: _muted,
                              size: 22,
                            ),
                            onPressed: () => setState(
                                () => _obscureConfirm = !_obscureConfirm),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: _termsAccepted,
                            activeColor: _primary,
                            onChanged: (v) =>
                                setState(() => _termsAccepted = v ?? false),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => setState(
                                      () => _termsAccepted = !_termsAccepted,
                                    ),
                                    child: Text(
                                      l10n.authTermsAgree,
                                      style: const TextStyle(
                                        fontSize: 13.5,
                                        height: 1.35,
                                        color: _text,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.only(left: 4),
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push<void>(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const TermsPlaceholderScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      l10n.authTermsOpen,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      const SizedBox(height: 6),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed:
                              _submitting ? null : () => _forgotPassword(l10n),
                          style: TextButton.styleFrom(
                            foregroundColor: _primary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                          ),
                          child: Text(
                            l10n.authForgotPassword,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _submitting ? null : () => _submit(l10n),
                  child: _submitting
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _isSignUp
                                  ? l10n.authSignUpButton
                                  : l10n.authSignInButton,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              _isSignUp
                                  ? Icons.person_add_rounded
                                  : Icons.login_rounded,
                              size: 20,
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isSignUp
                        ? l10n.authToggleHasAccount
                        : l10n.authToggleNoAccount,
                    style: const TextStyle(color: _muted, fontSize: 14),
                  ),
                  const SizedBox(width: 6),
                  TextButton(
                    onPressed: _submitting
                        ? null
                        : () => setState(() {
                              _isSignUp = !_isSignUp;
                              if (!_isSignUp) _confirm.clear();
                            }),
                    style: TextButton.styleFrom(
                      foregroundColor: _primary,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      _isSignUp
                          ? l10n.authToggleSignIn
                          : l10n.authToggleSignUp,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModeToggle extends StatelessWidget {
  final bool isSignUp;
  final AppLocalizations l10n;
  final ValueChanged<bool> onChanged;

  const _ModeToggle({
    required this.isSignUp,
    required this.l10n,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ModeChip(
              selected: !isSignUp,
              label: l10n.authSignInButton,
              onTap: () => onChanged(false),
            ),
          ),
          Expanded(
            child: _ModeChip(
              selected: isSignUp,
              label: l10n.authSignUpButton,
              onTap: () => onChanged(true),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeChip extends StatelessWidget {
  final bool selected;
  final String label;
  final VoidCallback onTap;

  const _ModeChip({
    required this.selected,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF00ACC1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
              color: selected ? Colors.white : const Color(0xFF9E9E9E),
            ),
          ),
        ),
      ),
    );
  }
}
