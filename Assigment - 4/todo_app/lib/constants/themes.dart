import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

// final lightTheme = ThemeData.light(useMaterial3: true).copyWith(primaryColor: Colors.yellow, );
// final darkTheme = ThemeData.dark(useMaterial3: true).copyWith(primaryColor: Colors.green, primaryTextTheme: TextTheme());

class MyTheme {
  static final box = GetStorage();

  static Color get background => _backgroundColor();
  static Color get text => _textColor();
  static get toggleTheme => _toggleTheme();

  static Color _backgroundColor() {
    return (box.read("darkMode") ?? true)
        ? const Color(0xFF212121)
        : const Color(0xFFFFFFFF);
  }

  static Color _textColor() {
    return (box.read("darkMode") ?? true)
        ? Colors.white.withOpacity(.9)
        : Colors.black.withOpacity(.9);
  }

  static void _toggleTheme() {
    box.write('darkMode', !(box.read("darkMode") ?? true));
  }
}
