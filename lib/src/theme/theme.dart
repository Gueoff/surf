import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeStyle {
  static final lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromRGBO(97, 216, 240, 1),
        primary: Colors.white,
        secondary: const Color.fromRGBO(97, 216, 240, 1),
        tertiary: const Color.fromRGBO(2, 66, 102, 1),
        background: Colors.white,
        onPrimary: Color.fromRGBO(208, 217, 222, 1),
        onBackground: Color.fromRGBO(208, 217, 222, 1),
        onSecondary: Colors.white,
        error: Colors.red),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.niramit(
          fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -1.5),
      displayMedium: GoogleFonts.niramit(
          color: const Color.fromRGBO(2, 66, 102, 1),
          fontSize: 45,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5),
      displaySmall:
          GoogleFonts.niramit(fontSize: 36, fontWeight: FontWeight.w400),
      headlineLarge: GoogleFonts.niramit(
          fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      headlineMedium: GoogleFonts.niramit(
          fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      headlineSmall:
          GoogleFonts.niramit(fontSize: 24, fontWeight: FontWeight.w400),
      titleLarge: GoogleFonts.niramit(
          color: const Color.fromRGBO(2, 66, 102, 1),
          fontSize: 22,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15),
      titleMedium: GoogleFonts.niramit(
          fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
      titleSmall: GoogleFonts.niramit(
          fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      bodyLarge: GoogleFonts.niramit(
          fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
      bodyMedium: GoogleFonts.niramit(
          fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      bodySmall: GoogleFonts.niramit(
          fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 1.25),
      labelLarge: GoogleFonts.niramit(
          fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      labelMedium: GoogleFonts.niramit(
          fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 1.5),
      labelSmall: GoogleFonts.niramit(
          fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 1.5),
    ),
  );
}
