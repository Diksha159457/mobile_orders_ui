// Imports standard Material Design components from Flutter.
import 'package:flutter/material.dart';
// Imports the Google Fonts package to use beautiful typography (Inter).
import 'package:google_fonts/google_fonts.dart';

// Centralized configuration class that holds all colors, typographies, and theming.
class AppTheme {
  // Brand color definition
  static const Color primaryBlue = Color(0xFF2563EB); // A soft, standard vibrant blue.
  
  // Light Mode Color Palette Definitions
  static const Color backgroundLight = Color(0xFFF8FAFC); // Very faint grayish-blue for light mode background.
  static const Color surfaceLight = Colors.white; // Pure white for cards and floating elements in light mode.
  static const Color textPrimaryLight = Color(0xFF0F172A); // Almost black for high legibility on light backgrounds.
  static const Color textSecondaryLight = Color(0xFF64748B); // Slate gray for secondary details.

  // Dark Mode Color Palette Definitions
  static const Color backgroundDark = Color(0xFF0F172A); // Deep slate/bluish-black for dark mode base background.
  static const Color surfaceDark = Color(0xFF1E293B); // Slightly lighter slate for cards in dark mode.
  static const Color textPrimaryDark = Color(0xFFF8FAFC); // Off-white for sharp contrast reading on dark mode.
  static const Color textSecondaryDark = Color(0xFF94A3B8); // Muted slate gray for secondary details in dark mode.

  // Semantic Colors used explicitly to indicate financial context.
  static const Color buyGreen = Color(0xFF10B981); // Emerald green for 'Buy' and positive sentiment.
  static const Color sellRed = Color(0xFFEF4444); // Crimson red for 'Sell' and negative sentiment/errors.

  // The comprehensive configuration payload returned for Flutter's Light Theme.
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light, // Instructs Flutter widgets to assume a bright background.
      primaryColor: primaryBlue, // Sets the application's primary brand color.
      scaffoldBackgroundColor: backgroundLight, // The default base color of any Scaffold widget screen.
      colorScheme: const ColorScheme.light( // Replaces legacy colors, defining how default widgets paint.
        primary: primaryBlue,
        surface: surfaceLight,
        error: sellRed, // Maps error bounds to our semantic 'sell' red for consistency.
      ),
      // Integrates 'Inter' as the global font, overriding standard Material text specs for light mode readability.
      textTheme: GoogleFonts.interTextTheme().copyWith(
        titleLarge: GoogleFonts.inter( // Used for Headers, like "Open Orders".
          color: textPrimaryLight,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        bodyLarge: GoogleFonts.inter(color: textPrimaryLight), // Standard important text.
        bodyMedium: GoogleFonts.inter(color: textSecondaryLight), // Demoted or secondary UI labeling.
      ),
      // Styles for the top navigation bar.
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundLight, // Blends perfectly with scaffold for flat, modern look.
        elevation: 0, // Removes the drop shadow to keep it clean.
        iconTheme: IconThemeData(color: textPrimaryLight), // Ensures back/menu icons are visible.
        titleTextStyle: TextStyle( // Enforces the typography of App Bar titles.
          color: textPrimaryLight,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      // Rules globally setting how every 'Card' widget handles layout and styling.
      cardTheme: CardTheme(
        color: surfaceLight, // White background for the card body.
        elevation: 2, // Minimal physical elevation depth.
        shadowColor: Colors.black.withOpacity(0.05), // An extremely subtle shadow drop for depth.
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Rounding the corners cleanly.
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Standardizes spacing outside the card container.
      ),
      // Controls styling on TextFields, such as the Search Bar.
      inputDecorationTheme: InputDecorationTheme(
        filled: true, // Forces textfields to draw their custom background colors.
        fillColor: surfaceLight, // Matches the textfield body to the card colors.
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0), // Pushes text inward safely.
        border: OutlineInputBorder( // The outer border of the textfield.
          borderRadius: BorderRadius.circular(12), // Highly rounded textfields.
          borderSide: BorderSide.none, // We remove the hard line border in favor of pure color filling.
        ),
        hintStyle: const TextStyle(color: textSecondaryLight), // Placeholder text styling.
      ),
    );
  }

  // The comprehensive configuration payload returned for Flutter's Dark Theme.
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark, // Instructs Flutter components to prepare for dark mode rendering.
      primaryColor: primaryBlue, // Brand color remains the same.
      scaffoldBackgroundColor: backgroundDark, // Base black/slate background.
      colorScheme: const ColorScheme.dark( // Defines how default material widgets paint in the dark.
        primary: primaryBlue,
        surface: surfaceDark,
        error: sellRed,
      ),
      // Reconstitutes the text themes, but mapping them to off-white and lighter grays.
      textTheme: GoogleFonts.interTextTheme().copyWith(
          titleLarge: GoogleFonts.inter( // High emphasis headers.
            color: textPrimaryDark,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          bodyLarge: GoogleFonts.inter(color: textPrimaryDark), // Standard content color.
          bodyMedium: GoogleFonts.inter(color: textSecondaryDark)), // Subtitles and timestamps.
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundDark, // Blends flatly against the dark scaffold background.
        elevation: 0, // Flattens it out.
        iconTheme: IconThemeData(color: textPrimaryDark), // Ensures navigation pieces are bright enough to see.
        titleTextStyle: TextStyle(
          color: textPrimaryDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardTheme(
        color: surfaceDark, // Maps cards to the dark slate 'surface'.
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.2), // Dark mode needs slightly heavier shadow opacities to be visible.
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceDark, // Textfields share the darker slate box color.
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: textSecondaryDark), // Muted hint texts.
      ),
    );
  }
}
