import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: const Color.fromARGB(255, 0, 5, 12),
    primary: Color.fromARGB(255, 20, 30, 40),
    secondary: Color.fromARGB(255, 40, 60, 80),
    tertiary: Colors.grey.shade300,
    inversePrimary: Colors.grey.shade100,
    primaryContainer: const Color.fromARGB(255, 250, 192, 0),
    onPrimary: Color.fromARGB(255, 255, 250, 240),
    onSecondary: const Color.fromARGB(255, 32, 32, 32),
    onTertiary: Colors.white,
  ),
);
