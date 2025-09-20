import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  fontFamily: 'Sora',
  colorScheme: ColorScheme.light(
    primary: Colors.grey.shade600,
    secondary: Colors.grey.shade300,
    tertiary: Colors.white,
    inversePrimary: Color(0xff0D1B2A),
    onPrimary: const Color(0xFF0E7C57),
    error: Colors.red,
  ),
  scaffoldBackgroundColor: Colors.grey.shade200,
);

ThemeData darkMode = ThemeData(
  fontFamily: 'Sora',
  colorScheme: ColorScheme.dark(
    primary: Colors.grey.shade500,
    secondary: const Color.fromARGB(255, 39, 39, 39),
    tertiary: const Color.fromARGB(255, 25, 25, 25),
    inversePrimary: Colors.grey.shade300,
    onPrimary: const Color(0xFF0E7C57),
    error: Colors.red[700]!,
  ),
  scaffoldBackgroundColor: Colors.grey.shade900,
);
