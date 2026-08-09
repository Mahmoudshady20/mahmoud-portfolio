import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';

abstract class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: AppTypography.fontPrimary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.purple,
        surface: AppColors.surface,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.borderFaint,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
