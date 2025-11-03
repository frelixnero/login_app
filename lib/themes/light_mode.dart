import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade100,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    tertiary: Colors.grey.shade600,
    inversePrimary: Colors.grey.shade900,
    primaryContainer: const Color.fromARGB(255, 250, 192, 0),
    onPrimary: Color.fromARGB(255, 255, 250, 240),
    onSecondary: const Color.fromARGB(255, 32, 32, 32),
    onTertiary: Colors.white,
    onSurface: Colors.grey.shade800,
  ),
);
