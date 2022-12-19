import 'package:flutter/material.dart';

final applicationTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF5EB0FF),
    secondary: Color(0xFF0484FF),
    secondaryContainer: Color(0xFF6daeed),
    background: Color(0xFFf5f5f5),
  ),
  textTheme: const TextTheme(
    headline2: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: Color(0xFFFFFFFF),
    ),
    bodyText2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Color(0xFFFFFFFF),
    ),
    subtitle1: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Color(0xFFFFFFFF),
    ),
    button: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Color(0xFF0484FF),
    ),
    bodyText1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w800,
      color: Colors.black87,
    ),
  ),
);

// primary: Color(linear-gradient(360deg, #0484FF -62.7%, #5EB0FF 100%))
