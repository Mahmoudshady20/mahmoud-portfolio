import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';

abstract class AppTypography {
  static const String fontPrimary = 'SpaceGrotesk';
  static const String fontMono = 'JetBrainsMono';

  static const TextStyle heroDisplay = TextStyle(
    fontFamily: fontPrimary,
    fontSize: 72,
    fontWeight: FontWeight.w700,
    height: 1.05,
    letterSpacing: -1.8,
    color: AppColors.textWhite,
  );

  static const TextStyle heroDisplayLight = TextStyle(
    fontFamily: fontPrimary,
    fontSize: 72,
    fontWeight: FontWeight.w300,
    height: 1.05,
    letterSpacing: -1.8,
    color: Color(0xB3E8EDF5), // rgba(232, 237, 245, 0.7)
  );

  static const TextStyle heroDisplayMobile = TextStyle(
    fontFamily: fontPrimary,
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 1.1,
    letterSpacing: -1.2,
    color: AppColors.textWhite,
  );

  static const TextStyle sectionTag = TextStyle(
    fontFamily: fontMono,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.2,
    height: 1.33,
    color: AppColors.primary,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: fontPrimary,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 1.11,
    letterSpacing: -0.8,
    color: AppColors.textWhite,
  );

  static const TextStyle h2Mobile = TextStyle(
    fontFamily: fontPrimary,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.15,
    letterSpacing: -0.6,
    color: AppColors.textWhite,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: fontPrimary,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.33,
    letterSpacing: -0.4,
    color: AppColors.textWhite,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: fontPrimary,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.textWhite,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.625, // 26px line height on 16px font
    color: Color(0x8CE8EDF5), // rgba(232, 237, 245, 0.55)
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontPrimary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.714, // 24px line height on 14px font
    color: AppColors.textMuted,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontPrimary,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
    color: AppColors.textSubtle,
  );

  static const TextStyle buttonText = TextStyle(
    fontFamily: fontPrimary,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.5, // 21px / 14px
    color: AppColors.textWhite,
  );

  static const TextStyle navItem = TextStyle(
    fontFamily: fontPrimary,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.43, // 20px / 14px
    color: AppColors.textSecondary,
  );

  static const TextStyle navItemActive = TextStyle(
    fontFamily: fontPrimary,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.43,
    color: AppColors.primary,
  );

  static const TextStyle codeSnippet = TextStyle(
    fontFamily: fontMono,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.66,
    color: AppColors.textPrimary,
  );

  static const TextStyle badgeMono = TextStyle(
    fontFamily: fontMono,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
    color: AppColors.primary,
  );

  static const TextStyle badgePill = TextStyle(
    fontFamily: fontPrimary,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  static const TextStyle statNumber = TextStyle(
    fontFamily: fontPrimary,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.33,
    letterSpacing: -0.5,
    color: AppColors.textWhite,
  );

  static const TextStyle statLabel = TextStyle(
    fontFamily: fontMono,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
    color: AppColors.textSubtle,
  );
}
