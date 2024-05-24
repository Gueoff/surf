import 'package:flutter/material.dart';

const Color primary = Color.fromRGBO(255, 255, 255, 1);
const Color secondary = Color.fromRGBO(149, 229, 254, 1);
const Color tertiary = Color.fromRGBO(12, 68, 93, 1);
const Color quaternary = Color.fromRGBO(206, 237, 242, 1);

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
        error: Colors.red),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'NoyhR-Medium',
        color: tertiary,
        fontSize: 57,
      ),
      displayMedium: TextStyle(
        fontFamily: 'NoyhR-Medium',
        color: tertiary,
        fontSize: 45,
      ),
      displaySmall: TextStyle(
        fontFamily: 'NoyhR-Medium',
        color: tertiary,
        fontSize: 36,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'NoyhR-Medium',
        color: tertiary,
        fontSize: 32,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'NoyhR-Medium',
        color: tertiary,
        fontSize: 28,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'NoyhR-Medium',
        color: tertiary,
        fontSize: 24,
      ),
      titleLarge: TextStyle(
        fontFamily: 'NoyhR-Regular',
        color: tertiary,
        fontSize: 22,
      ),
      titleMedium: TextStyle(
        fontFamily: 'NoyhR-Regular',
        color: tertiary,
        fontSize: 20,
      ),
      titleSmall: TextStyle(
        fontFamily: 'NoyhR-Regular',
        color: tertiary,
        fontSize: 18,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'NoyhR-SemiLight',
        color: tertiary,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'NoyhR-SemiLight',
        color: tertiary,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        fontFamily: 'NoyhR-SemiLight',
        color: tertiary,
        fontSize: 12,
      ),
      labelLarge: TextStyle(
        fontFamily: 'NoyhR-Light',
        color: tertiary,
        fontSize: 16,
      ),
      labelMedium: TextStyle(
        fontFamily: 'NoyhR-Light',
        color: tertiary,
        fontSize: 14,
      ),
      labelSmall: TextStyle(
        fontFamily: 'NoyhR-Light',
        color: tertiary,
        fontSize: 12,
      ),
    ),
  );
}
