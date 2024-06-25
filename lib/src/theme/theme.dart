import 'package:flutter/material.dart';

const Color primary = Color.fromRGBO(255, 255, 255, 1);
const Color secondary = Color.fromRGBO(149, 229, 254, 1);
const Color tertiary = Color.fromRGBO(12, 68, 93, 1);
const Color quaternary = Color.fromRGBO(206, 237, 242, 1);
const Color yellow = Color.fromRGBO(252, 220, 18, 1);

class ThemeStyle {
  static final lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: secondary,
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      surface: quaternary,
      onPrimary: tertiary,
      onSecondary: primary,
      error: Colors.red,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Font-Medium',
        color: tertiary,
        fontSize: 57,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Font-Medium',
        color: tertiary,
        fontSize: 45,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Font-Medium',
        color: tertiary,
        fontSize: 36,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Font-Medium',
        color: tertiary,
        fontSize: 28,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Font-Medium',
        color: tertiary,
        fontSize: 24,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Font-Medium',
        color: tertiary,
        fontSize: 20,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Font-Regular',
        color: tertiary,
        fontSize: 18,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Font-Regular',
        color: tertiary,
        fontSize: 16,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Font-Regular',
        color: tertiary,
        fontSize: 14,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Font-SemiLight',
        color: tertiary,
        fontSize: 12,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Font-SemiLight',
        color: tertiary,
        fontSize: 10,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Font-SemiLight',
        color: tertiary,
        fontSize: 8,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Font-SemiLight',
        color: tertiary,
        fontSize: 12,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Font-SemiLight',
        color: tertiary,
        fontSize: 10,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Font-SemiLight',
        color: tertiary,
        fontSize: 8,
      ),
    ),
  );
}
