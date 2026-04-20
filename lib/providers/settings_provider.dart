import 'package:flutter/material.dart';

import '../models/settings_models.dart';
import '../services/settings_service.dart';

class SettingsProvider extends ChangeNotifier {
  final SettingsService _service;

  SettingsProvider({SettingsService? service}) : _service = service ?? SettingsService.instance;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  UserProfile? _profile;
  UserProfile? get profile => _profile;

  List<String> _dietaryPreferences = const [];
  List<String> get dietaryPreferences => List.unmodifiable(_dietaryPreferences);

  PremiumStatus _premiumStatus = PremiumStatus.none;
  PremiumStatus get premiumStatus => _premiumStatus;

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;

  bool _savingProfile = false;
  bool get savingProfile => _savingProfile;

  bool _savingDietary = false;
  bool get savingDietary => _savingDietary;

  bool _savingAppPrefs = false;
  bool get savingAppPrefs => _savingAppPrefs;

  Future<void> load() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _service.getUserProfile(),
        _service.getDietaryPreferences(),
        _service.getPremiumStatus(),
        _service.getThemeMode(),
        _service.getNotificationsEnabled(),
      ]);

      _profile = results[0] as UserProfile;
      _dietaryPreferences = (results[1] as List<String>).toSet().toList()..sort();
      _premiumStatus = results[2] as PremiumStatus;
      _themeMode = results[3] as ThemeMode;
      _notificationsEnabled = results[4] as bool;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile({required String fullName}) async {
    if (_savingProfile) return;
    _savingProfile = true;
    notifyListeners();
    try {
      await _service.updateUserProfile(fullName: fullName);
      _profile = (_profile ?? (await _service.getUserProfile())).copyWith(fullName: fullName.trim());
    } finally {
      _savingProfile = false;
      notifyListeners();
    }
  }

  bool hasDietPref(String key) => _dietaryPreferences.contains(key);

  Future<void> toggleDietPref(String key) async {
    final next = _dietaryPreferences.toSet();
    if (next.contains(key)) {
      next.remove(key);
    } else {
      next.add(key);
    }
    _dietaryPreferences = next.toList()..sort();
    notifyListeners();

    if (_savingDietary) return;
    _savingDietary = true;
    notifyListeners();
    try {
      await _service.saveDietaryPreferences(_dietaryPreferences);
    } finally {
      _savingDietary = false;
      notifyListeners();
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_savingAppPrefs) return;
    _themeMode = mode;
    notifyListeners();
    _savingAppPrefs = true;
    notifyListeners();
    try {
      await _service.setThemeMode(mode);
    } finally {
      _savingAppPrefs = false;
      notifyListeners();
    }
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    if (_savingAppPrefs) return;
    _notificationsEnabled = enabled;
    notifyListeners();
    _savingAppPrefs = true;
    notifyListeners();
    try {
      await _service.setNotificationsEnabled(enabled);
    } finally {
      _savingAppPrefs = false;
      notifyListeners();
    }
  }

  Future<void> mockBuyPremiumMonthly() async {
    await _service.mockPurchasePremium(duration: const Duration(days: 31));
    _premiumStatus = await _service.getPremiumStatus();
    notifyListeners();
  }

  Future<void> mockBuyPremiumYearly() async {
    await _service.mockPurchasePremium(duration: const Duration(days: 365));
    _premiumStatus = await _service.getPremiumStatus();
    notifyListeners();
  }

  Future<void> logout() => _service.logout();
}

