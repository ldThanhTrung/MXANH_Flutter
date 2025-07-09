import 'package:flutter/material.dart';
// import 'package:mxanh_flutter/login.dart';
import 'package:mxanh_flutter/themes/app_theme.dart';
import 'package:mxanh_flutter/screens/home_page.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    themeMode: ThemeMode.system,
    debugShowCheckedModeBanner: false,
  ));
}
