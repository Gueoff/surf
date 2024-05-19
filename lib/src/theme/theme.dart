import 'package:flutter/material.dart';

class ThemeStyle {
  static final lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromRGBO(97, 216, 240, 1),
        primary: Colors.white,
        secondary: const Color.fromRGBO(97, 216, 240, 1),
        tertiary: const Color.fromRGBO(2, 66, 102, 1),
        onPrimary: const Color.fromRGBO(200, 210, 212, 1),
        onSecondary: Colors.white,
        error: Colors.red),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'NoyhR-Medium',
        color: Color.fromRGBO(2, 66, 102, 1),
        fontSize: 57,
      ),
      displayMedium: TextStyle(
        fontFamily: 'NoyhR-Medium',
        color: Color.fromRGBO(2, 66, 102, 1),
        fontSize: 45,
      ),
      displaySmall: TextStyle(
        fontFamily: 'NoyhR-Medium',
        color: Color.fromRGBO(2, 66, 102, 1),
        fontSize: 36,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'NoyhR-Medium',
        color: Color.fromRGBO(2, 66, 102, 1),
        fontSize: 32,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'NoyhR-Medium',
        color: Color.fromRGBO(2, 66, 102, 1),
        fontSize: 28,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'NoyhR-Medium',
        color: Color.fromRGBO(2, 66, 102, 1),
        fontSize: 24,
      ),
      titleLarge: TextStyle(
        fontFamily: 'NoyhR-Regular',
        color: Color.fromRGBO(2, 66, 102, 1),
        fontSize: 22,
      ),
      titleMedium: TextStyle(
        fontFamily: 'NoyhR-Regular',
        color: Color.fromRGBO(2, 66, 102, 1),
        fontSize: 20,
      ),
      titleSmall: TextStyle(
        fontFamily: 'NoyhR-Regular',
        color: Color.fromRGBO(2, 66, 102, 1),
        fontSize: 18,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'NoyhR-SemiLight',
        color: Color.fromRGBO(2, 66, 102, 1),
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'NoyhR-SemiLight',
        color: Color.fromRGBO(2, 66, 102, 1),
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        fontFamily: 'NoyhR-SemiLight',
        color: Color.fromRGBO(2, 66, 102, 1),
        fontSize: 12,
      ),
      labelLarge: TextStyle(
        fontFamily: 'NoyhR-Light',
        color: Color.fromRGBO(2, 66, 102, 1),
        fontSize: 16,
      ),
      labelMedium: TextStyle(
        fontFamily: 'NoyhR-Light',
        color: Color.fromRGBO(2, 66, 102, 1),
        fontSize: 14,
      ),
      labelSmall: TextStyle(
        fontFamily: 'NoyhR-Light',
        color: Color.fromRGBO(2, 66, 102, 1),
        fontSize: 12,
      ),
    ),
  );
}
