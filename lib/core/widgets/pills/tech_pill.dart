import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_decorations.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';

class TechPill extends StatelessWidget {
  final String label;
  final bool isAccent;

  const TechPill({
    super.key,
    required this.label,
    this.isAccent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isAccent ? AppColors.primary.withValues(alpha: 0.1) : AppColors.glassSurface,
        borderRadius: AppDecorations.radiusSm,
        border: Border.all(
          color: isAccent ? AppColors.primary.withValues(alpha: 0.3) : AppColors.borderSubtle,
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: AppTypography.badgePill.copyWith(
          color: isAccent ? AppColors.primary : AppColors.textPrimary,
          fontSize: 13,
        ),
      ),
    );
  }
}
