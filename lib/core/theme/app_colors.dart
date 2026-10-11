import 'package:flutter/material.dart';

abstract class AppColors {
  // Backgrounds
  static const Color background = Color(0xFFF6F4EF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFEDEAE3);

  // Glassmorphism surfaces
  static const Color glassSurface = Color(0x0AFFFFFF);
  static const Color glassSurfaceHover = Color(0xFFDDDCD5);

  // Primary Brand Colors
  static const Color primary = Color(0xFF694D91);
  static const Color primaryLight = Color(0xFF7B6EF6);
  static const Color purple = Color(0xFF8B5CF6);
  static const Color cyan = Color(0xFF22D3EE);
  static const Color green = Color(0xFF10B981);
  static const Color orange = Color(0xFFFFA000);

  // Text Colors
  static const Color textWhite = Color(0xFF222322);
  static const Color textPrimary = Color(0xFF222322);
  static const Color textSecondary = Color(0xFF62645F);
  static const Color textMuted = Color(0xFF62645F);
  static const Color textSubtle = Color(0xFF62645F);
  static const Color textFaint = Color(0xFF62645F);

  // Borders
  static const Color borderSubtle = Color(0xFFDDDCD5);
  static const Color borderFaint = Color(0xFFE2E1DA);
  static const Color borderPrimary = Color(0x4D4F8CFF);

  // Traffic Lights
  static const Color dotRed = Color(0xFFFF5F56);
  static const Color dotYellow = Color(0xFFFFBD2E);
  static const Color dotGreen = Color(0xFF27C93F);

  // Syntax tokens
  static const Color syntaxKeyword = Color(0xFF569CD6);
  static const Color syntaxType = Color(0xFF4EC9B0);
  static const Color syntaxFunction = Color(0xFFDCDCAA);
  static const Color syntaxVariable = Color(0xFF9CDCFE);
  static const Color syntaxString = Color(0xFFCE9178);
  static const Color syntaxControl = Color(0xFFC586C0);
  static const Color syntaxGold = Color(0xFFFFD700);
  static const Color syntaxBracket = Color(0xFFDA70D6);
}
