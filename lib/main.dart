import 'dart:io';
import 'package:flutter/material.dart';
import "login.dart";
import 'themes/app_theme.dart';
import 'signup.dart';
import 'welcome.dart';
import 'start_page.dart';




void main() {
  runApp(MaterialApp(
    home: HomePage(),
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

