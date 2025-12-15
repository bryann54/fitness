import 'package:flutter/material.dart';

// Helper function to dynamically check theme (kept for potential future use)
bool isDarkTheme(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

class AppColors {
  // Theme-Specific Colors (Based on your App's Design)
  static const Color primary = Colors.teal; // Orange/Accent Color
  static const Color secondary = Color(0xFF1E88E5); // Blue secondary accent
  static const Color accent = Color(0xFFFF9800);
  static const Color coffeeBrownDark = Color(0xFFFFA726);
  static const Color coffeeBrownLight = Color(0xFFFFCC80);
  static const Color coffeeBrownMedium = Color(0xFFFFE0B2);

  // Backgrounds
  static const Color backgroundDark = Colors.black;
  static const Color backgroundLight = Colors.white;

  // UI/Card Colors
  static const Color cardDark = Color(0xFF2C2C2C); // Dark Card/Input Fill
  static const Color cardLight = Color(0xFFF0F0F0); // Light Card/Input Fill

  // Text Colors (Adapting for Dark Background)
  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF495057);
  static const Color textLight = Color(0xFF6C757D);
  static const Color textLightDark = Color(0xFFADB5BD);
  static const Color textOnPrimary = Colors.grey;
  static const Color textPrimaryDark = Color(0xFFF8F9FA);
  static const Color textSecondaryDark = Color(0xFFE9ECEF);
  static const Color textAccent = Colors.black;
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);
  static const Color visualDarkBackgroundHalf =
      Color(0xFF1A1A1A); // Always the dark side of the split
  static const Color visualLightBackgroundHalf =
      Colors.white; // Always the light side of the split
  // Borders & Dividers
  static const Color borderColorDark = Color(0xFF3A3A3A);
  static const Color borderColorLight = Color(0xFFE0E0E0);
  static const Color dividerColor = Color(0xFF444444);
}
