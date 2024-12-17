import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData mainTheme = ThemeData(
  textTheme: GoogleFonts.poppinsTextTheme(),
  useMaterial3: true,
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Colors.white,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.red,
      surface: Colors.white,
      onSurface: Colors.black),
);
