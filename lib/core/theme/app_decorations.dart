import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';

abstract class AppDecorations {
  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(8));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(10));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(14));
  static const BorderRadius radiusXl = BorderRadius.all(Radius.circular(18));
  static const BorderRadius radiusPill = BorderRadius.all(Radius.circular(9999));

  static BoxDecoration glassBox({
    Color backgroundColor = AppColors.glassSurface,
    Color borderColor = AppColors.borderSubtle,
    BorderRadius borderRadius = radiusLg,
    List<BoxShadow>? shadows,
  }) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: borderRadius,
      border: Border.all(color: borderColor, width: 1),
      boxShadow: shadows,
    );
  }

  static BoxDecoration glassBoxHover({
    Color backgroundColor = AppColors.glassSurfaceHover,
    Color borderColor = AppColors.borderPrimary,
    BorderRadius borderRadius = radiusLg,
    List<BoxShadow>? shadows,
  }) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: borderRadius,
      border: Border.all(color: borderColor, width: 1),
      boxShadow: shadows ??
          [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.15),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
    );
  }

  static List<BoxShadow> primaryGlowShadow = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.35),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> ideWindowShadow = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.2),
      blurRadius: 80,
      offset: const Offset(0, 30),
    ),
  ];
}
