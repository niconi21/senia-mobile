import 'package:flutter/material.dart';

class AppTheme {
  // primarySwatch: Colors.indigo,

  static const MaterialColor primaryColorSwatch = Colors.brown;
  static const Color primaryColor = Color.fromARGB(255, 209, 192, 146);
  static const Color secondaryColor = Color.fromARGB(255, 22, 68, 105);
  static const Color dangerColor = Color.fromARGB(255, 138, 11, 2);
  static const Color accentColor = Color.fromARGB(255, 85, 73, 44);
  static const Color white = Color.fromARGB(255, 255, 255, 255);

  static const Color selectedColor = Color.fromARGB(255, 13, 41, 46);
  static const Color unselectedColor = Color.fromARGB(255, 72, 73, 73);
  static const Color backgroundColor = Color.fromARGB(255, 254, 240, 203);

  static final theme = ThemeData(
    primarySwatch: primaryColorSwatch,
    primaryColor: primaryColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: accentColor,
        shape: const StadiumBorder(),
        elevation: 10,
        textStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
