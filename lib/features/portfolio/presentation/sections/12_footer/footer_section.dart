import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahmoud_portfolio/core/constants/app_constants.dart';
import 'package:mahmoud_portfolio/core/responsive/breakpoints.dart';
import 'package:mahmoud_portfolio/core/responsive/responsive_builder.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_decorations.dart';
import 'package:mahmoud_portfolio/core/theme/app_gradients.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';
import 'package:mahmoud_portfolio/core/utils/url_helper.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/cubit/navigation_cubit.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, screenType) {
        final isMobile = screenType.isMobile;

        return Container(
          height: isMobile ? null : 97,
          decoration: const BoxDecoration(
            color: AppColors.background,
            border: Border(
              top: BorderSide(color: AppColors.borderFaint, width: 1),
            ),
          ),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: isMobile ? 28 : 0,
              ),
              child: isMobile
                  ? Column(
                      children: [
                        _buildLogo(context),
                        const SizedBox(height: 16),
                        _buildCopyright(),
                        const SizedBox(height: 16),
                        _buildSocialIcons(),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLogo(context),
                        _buildCopyright(),
                        _buildSocialIcons(),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogo(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.read<NavigationCubit>().scrollToSection('home'),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: AppGradients.primaryButton,
                borderRadius: AppDecorations.radiusSm,
              ),
              child: const Center(
                child: Text(
                  AppConstants.developerInitials,
                  style: TextStyle(
                    fontFamily: AppTypography.fontPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              AppConstants.developerName,
              style: TextStyle(
                fontFamily: AppTypography.fontPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xCCE8EDF5), // rgba(255, 255, 255, 0.8)
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCopyright() {
    return Text(
      AppConstants.copyrightText,
      style: TextStyle(
        fontFamily: AppTypography.fontPrimary,
        fontSize: 13,
        color: const Color(0x66E8EDF5), // rgba(232, 237, 245, 0.4)
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIconGlyph("⑂", () => UrlHelper.openUrl(AppConstants.githubUrl)),
        const SizedBox(width: 18),
        _buildIconGlyph("◉", () => UrlHelper.openUrl(AppConstants.linkedinUrl)),
        const SizedBox(width: 18),
        _buildIconGlyph("✉", () => UrlHelper.sendEmail(AppConstants.email)),
      ],
    );
  }

  Widget _buildIconGlyph(String glyph, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          glyph,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0x73E8EDF5), // rgba(232, 237, 245, 0.45)
          ),
        ),
      ),
    );
  }
}
