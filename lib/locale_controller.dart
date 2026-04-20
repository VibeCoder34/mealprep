import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends ChangeNotifier {
  static const _prefsKey = 'app_locale_code';

  static const supportedLocales = [
    Locale('en'),
    Locale('es'),
    Locale('tr'),
  ];

  Locale _locale = const Locale('tr');
  Locale get locale => _locale;

  LocaleController() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_prefsKey);
    if (code != null && _isSupportedCode(code)) {
      _locale = Locale(code);
      notifyListeners();
    }
  }

  bool _isSupportedCode(String code) =>
      supportedLocales.any((l) => l.languageCode == code);

  Future<void> setLocale(Locale locale) async {
    if (!_isSupportedCode(locale.languageCode)) return;
    _locale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, locale.languageCode);
  }
}
