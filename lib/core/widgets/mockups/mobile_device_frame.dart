import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_decorations.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';

class MobileDeviceFrame extends StatelessWidget {
  final String title;
  final String category;
  final Color accentColor;
  final double width;
  final double height;

  const MobileDeviceFrame({
    super.key,
    required this.title,
    required this.category,
    this.accentColor = AppColors.primary,
    this.width = 220,
    this.height = 360,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF0F141C),
        borderRadius: const BorderRadius.all(Radius.circular(28)),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.35),
          width: 2.5,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.25),
            blurRadius: 36,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 6),
            alignment: Alignment.center,
            child: Container(
              width: 54,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.borderSubtle,
                borderRadius: AppDecorations.radiusPill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "⬡",
                      style: TextStyle(fontSize: 10, color: accentColor),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: AppTypography.h4.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.notifications_none_rounded,
                  size: 14,
                  color: AppColors.textSubtle,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppDecorations.radiusMd,
                border: Border.all(color: AppColors.borderFaint),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          accentColor.withValues(alpha: 0.25),
                          AppColors.purple.withValues(alpha: 0.15),
                        ],
                      ),
                      borderRadius: AppDecorations.radiusSm,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.phone_iphone_rounded,
                        color: accentColor,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: AppTypography.h4.copyWith(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category,
                    style: AppTypography.bodySmall.copyWith(fontSize: 9),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 22,
                          decoration: BoxDecoration(
                            color: accentColor.withValues(alpha: 0.2),
                            borderRadius: AppDecorations.radiusSm,
                          ),
                          child: Center(
                            child: Text(
                              "Explore",
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: accentColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            alignment: Alignment.center,
            child: Container(
              width: 70,
              height: 3.5,
              decoration: BoxDecoration(
                color: AppColors.textSubtle.withValues(alpha: 0.4),
                borderRadius: AppDecorations.radiusPill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
