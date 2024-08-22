// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Light Mode
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  fontFamily: GoogleFonts.montserrat().fontFamily,
  colorScheme: ColorScheme.light(
    primary: const Color(0xFF673AB7), // Purple
    secondary: const Color(0xFFF50057), // Pink
    background: const Color(0xFFF5F5F5), // Light Grey
    surface: Colors.grey.shade300, // White
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onBackground: Colors.black,
    onSurface: Colors.black,
  ),
);

// Dark Mode
ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: GoogleFonts.montaga().fontFamily,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFD81B60), // Dark Pink
    secondary: Color(0xFF00BCD4), // Light Blue
    background: Color(0xFF212121), // Dark Grey
    surface: Color(0xFF303030), // Darker Grey
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onBackground: Colors.white,
    onSurface: Colors.white,
  ),
);
