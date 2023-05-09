import 'package:flutter/material.dart';

class AppThemes {

  static const Color primaryColor = Color.fromRGBO(90, 70, 178,1);

  static final ThemeData light = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.grey[300],
      appBarTheme: const AppBarTheme(
        color: primaryColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor
      )
  );

  static final ThemeData dark = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.grey[300],
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: primaryColor
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor
      )
  );

}