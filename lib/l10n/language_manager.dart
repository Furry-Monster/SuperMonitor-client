import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageManager extends ChangeNotifier {
  static const String _languageKey = 'language_code';
  static const String _followSystemKey = 'follow_system_language';
  final SharedPreferences _prefs;
  late Locale _locale;
  late bool _followSystem;

  LanguageManager(this._prefs) {
    _loadLanguageSettings();
  }

  Locale get locale => _locale;
  bool get followSystem => _followSystem;

  static const supportedLocales = [
    Locale('en'),
    Locale('zh'),
  ];

  static const languageNames = {
    'en': 'English',
    'zh': '中文',
  };

  void _loadLanguageSettings() {
    _followSystem = _prefs.getBool(_followSystemKey) ?? true;
    if (_followSystem) {
      _locale = _getCurrentSystemLocale();
    } else {
      final savedLanguage = _prefs.getString(_languageKey);
      _locale = savedLanguage != null ? Locale(savedLanguage) : const Locale('en');
    }
    notifyListeners();
  }

  Locale _getCurrentSystemLocale() {
    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
    if (supportedLocales.contains(Locale(systemLocale.languageCode))) {
      return Locale(systemLocale.languageCode);
    }
    return const Locale('en');
  }

  Future<void> setLocale(Locale newLocale) async {
    if (_locale == newLocale) return;
    _locale = newLocale;
    _followSystem = false;
    await _prefs.setString(_languageKey, newLocale.languageCode);
    await _prefs.setBool(_followSystemKey, false);
    notifyListeners();
  }

  Future<void> setFollowSystem(bool value) async {
    if (_followSystem == value) return;
    _followSystem = value;
    await _prefs.setBool(_followSystemKey, value);
    if (value) {
      _locale = _getCurrentSystemLocale();
    }
    notifyListeners();
  }
} 