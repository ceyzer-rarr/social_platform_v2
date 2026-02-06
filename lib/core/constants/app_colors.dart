import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Main brand color (still used for texts / icons)
  static const Color primary = Color(0xFF0033A1);

  // Background
  static const Color background = Color(0xFFF3F4FF);

  static const Color textPrimary = Color(0xFF1F2933);
  static const Color textSecondary = Color(0xFF9AA5B1);

  static const Color inputBorder = Color(0xFFE4E7EB);
  static const Color error = Colors.red;

  // Gradient primary button (Sign up / Log in)
  static const Color primaryGradientStart = Color(0xFF3B82F6); // blue
  static const Color primaryGradientEnd   = Color(0xFF9333EA); // purple

  // Social buttons
  static const Color socialButtonBg = Colors.white;
  static const Color socialButtonBorder = Color(0xFFE5E7EB);
}
