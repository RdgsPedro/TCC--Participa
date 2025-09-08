import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Poppins',
  colorScheme: ColorScheme.light(
    surface: Color(0xFFF8F8F8),
    primary: const Color(0xFF0E7C57),
    secondary: Colors.white,
    tertiary: Color(0xff0D1B2A),
    tertiaryContainer: Color.fromARGB(255, 255, 255, 255),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Poppins',
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: const Color(0xFF0E7C57),
    secondary: Colors.grey.shade800,
    tertiary: Colors.white,
    tertiaryContainer: Colors.grey.shade800,
  ),
);
