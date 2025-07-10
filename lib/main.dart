import 'dart:io';
import 'package:flutter/material.dart';
import "login.dart";
import 'themes/app_theme.dart';
import 'signup.dart';
import 'screens/welcome_page.dart';
import 'screens/start_page.dart';
import 'screens/home_page.dart';


void main() {
  runApp(MaterialApp(
    home: StartPage(),
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    themeMode: ThemeMode.system,
    debugShowCheckedModeBanner: false,
  ));

}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

