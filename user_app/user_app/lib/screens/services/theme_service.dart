import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  Themeservice() {
    _loadTheme();
  }
  void toggleTheme() async {
    _isDark = !_isDark;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', _isDark);
  }
  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    // Load theme from persistent storage if needed

    _isDark = prefs.getBool('isDark') ?? false;
    notifyListeners();
  }
}
