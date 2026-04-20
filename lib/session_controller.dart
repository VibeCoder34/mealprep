import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'services/supabase_service.dart';

/// Supabase auth session + onboarding flags.
class SessionController extends ChangeNotifier {
  static const _kOnboarding = 'session_onboarding_done';

  bool _ready = false;
  bool _onboardingDone = false;
  String? _userId;
  String _userEmail = '';
  String _userName = '';
  StreamSubscription<AuthState>? _authSub;

  bool get isReady => _ready;
  bool get isLoggedIn => _userId != null;
  bool get onboardingDone => _onboardingDone;
  String? get userId => _userId;
  String get userName => _userName;
  String get userEmail => _userEmail;

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    _onboardingDone = p.getBool(_kOnboarding) ?? false;

    final session = SupabaseService.instance.currentSession;
    final user = SupabaseService.instance.currentUser;
    if (session != null && user != null) {
      _userId = user.id;
      _userEmail = user.email ?? '';
      _userName = (user.userMetadata?['full_name'] as String?)?.trim() ?? '';
    } else {
      _userId = null;
      _userEmail = '';
      _userName = '';
    }

    _authSub?.cancel();
    _authSub = SupabaseService.instance.onAuthStateChange.listen((state) {
      final user = state.session?.user;
      if (user == null) {
        _userId = null;
        _userEmail = '';
        _userName = '';
      } else {
        _userId = user.id;
        _userEmail = user.email ?? '';
        _userName = (user.userMetadata?['full_name'] as String?)?.trim() ?? '';
      }
      notifyListeners();
    });

    _ready = true;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kOnboarding, true);
    _onboardingDone = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await SupabaseService.instance.signOut();
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }
}
