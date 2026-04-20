import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Mock auth + onboarding flags (no backend).
class SessionController extends ChangeNotifier {
  static const _kLoggedIn = 'session_is_logged_in';
  static const _kOnboarding = 'session_onboarding_done';
  static const _kUserName = 'session_user_name';
  static const _kUserEmail = 'session_user_email';

  bool _ready = false;
  bool _isLoggedIn = false;
  bool _onboardingDone = false;
  String _userName = '';
  String _userEmail = '';

  bool get isReady => _ready;
  bool get isLoggedIn => _isLoggedIn;
  bool get onboardingDone => _onboardingDone;
  String get userName => _userName;
  String get userEmail => _userEmail;

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    _isLoggedIn = p.getBool(_kLoggedIn) ?? false;
    _onboardingDone = p.getBool(_kOnboarding) ?? false;
    _userName = p.getString(_kUserName) ?? '';
    _userEmail = p.getString(_kUserEmail) ?? '';
    _ready = true;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kOnboarding, true);
    _onboardingDone = true;
    notifyListeners();
  }

  /// Simulated sign-in / sign-up (1–2s delay for UX).
  Future<void> authenticate({
    required String email,
    required String name,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kLoggedIn, true);
    await prefs.setString(_kUserEmail, email.trim());
    await prefs.setString(_kUserName, name.trim());
    _isLoggedIn = true;
    _userEmail = email.trim();
    _userName = name.trim();
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kLoggedIn, false);
    await prefs.remove(_kUserName);
    await prefs.remove(_kUserEmail);
    _isLoggedIn = false;
    _userName = '';
    _userEmail = '';
    notifyListeners();
  }
}
