import 'package:flutter/material.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

class AppTheme {
  static ThemeData light = lightTheme();
  static ThemeData dark = darkTheme();

  // static ThemeMode getThemeMode(bool isDarkMode) {
  //   return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  // }

  // static ThemeData getCurrentTheme(bool isDarkMode) {
  //   return isDarkMode ? darkTheme : lightTheme;
  // }

}

