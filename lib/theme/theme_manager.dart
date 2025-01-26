import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  static const String _themeColorKey = 'theme_color';
  final SharedPreferences _prefs;
  late ThemeMode _themeMode;
  late Color _themeColor;

  ThemeManager(this._prefs) {
    _loadThemeMode();
    _loadThemeColor();
  }

  ThemeMode get themeMode => _themeMode;
  Color get themeColor => _themeColor;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void _loadThemeMode() {
    final isDark = _prefs.getBool(_themeKey) ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void _loadThemeColor() {
    final colorValue = _prefs.getInt(_themeColorKey) ?? Colors.blue.value;
    _themeColor = Color(colorValue);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await _prefs.setBool(_themeKey, isDarkMode);
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    await _prefs.setBool(_themeKey, mode == ThemeMode.dark);
    notifyListeners();
  }

  Future<void> setThemeColor(Color color) async {
    if (_themeColor == color) return;
    _themeColor = color;
    await _prefs.setInt(_themeColorKey, color.value);
    notifyListeners();
  }
} 