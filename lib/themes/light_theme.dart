import 'package:flutter/material.dart';
import 'app_color.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.bodyColor,
    hintColor: AppColor.textColor,
    primaryColorLight: AppColor.buttonBackgroundColor,
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: Colors.black,
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.black,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}