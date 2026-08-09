import 'package:flutter/material.dart';

abstract class AppColors {
  // Backgrounds
  static const Color background = Color(0xFF0D1117);
  static const Color surface = Color(0xFF161B22);
  static const Color surfaceLight = Color(0xFF1C2030);

  // Glassmorphism surfaces
  static const Color glassSurface = Color(0x0AFFFFFF); // rgba(255, 255, 255, 0.04)
  static const Color glassSurfaceHover = Color(0x14FFFFFF); // rgba(255, 255, 255, 0.08)

  // Primary Brand Colors
  static const Color primary = Color(0xFF4F8CFF); // rgb(79, 140, 255)
  static const Color primaryLight = Color(0xFF7B6EF6); // rgb(123, 110, 246)
  static const Color purple = Color(0xFF8B5CF6); // rgb(139, 92, 246)
  static const Color cyan = Color(0xFF22D3EE); // rgb(34, 211, 238)
  static const Color green = Color(0xFF10B981); // rgb(16, 185, 129)
  static const Color orange = Color(0xFFFFA000); // rgb(255, 160, 0)

  // Text Colors
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFFE8EDF5);
  static const Color textSecondary = Color(0x99E8EDF5); // rgba(232, 237, 245, 0.6)
  static const Color textMuted = Color(0x80E8EDF5); // rgba(232, 237, 245, 0.5)
  static const Color textSubtle = Color(0x73E8EDF5); // rgba(232, 237, 245, 0.45)
  static const Color textFaint = Color(0x59E8EDF5); // rgba(232, 237, 245, 0.35)

  // Borders
  static const Color borderSubtle = Color(0x14FFFFFF); // rgba(255, 255, 255, 0.08)
  static const Color borderFaint = Color(0x0DFFFFFF); // rgba(255, 255, 255, 0.05)
  static const Color borderPrimary = Color(0x4D4F8CFF); // rgba(79, 140, 255, 0.3)

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
