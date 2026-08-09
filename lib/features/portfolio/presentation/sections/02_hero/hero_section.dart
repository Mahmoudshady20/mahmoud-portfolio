import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahmoud_portfolio/core/constants/app_constants.dart';
import 'package:mahmoud_portfolio/core/constants/app_strings.dart';
import 'package:mahmoud_portfolio/core/responsive/breakpoints.dart';
import 'package:mahmoud_portfolio/core/responsive/responsive_builder.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_decorations.dart';
import 'package:mahmoud_portfolio/core/theme/app_gradients.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';
import 'package:mahmoud_portfolio/core/utils/url_helper.dart';
import 'package:mahmoud_portfolio/core/widgets/buttons/app_gradient_button.dart';
import 'package:mahmoud_portfolio/core/widgets/buttons/app_icon_button.dart';
import 'package:mahmoud_portfolio/core/widgets/buttons/app_outline_button.dart';
import 'package:mahmoud_portfolio/core/widgets/mockups/code_editor_window.dart';
import 'package:mahmoud_portfolio/core/widgets/pills/status_badge.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/cubit/navigation_cubit.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, screenType) {
        final isDesktop = screenType.isDesktop;

        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: isDesktop ? 80 : 40,
            ),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 11,
                        child: _buildHeroLeftContent(context, isDesktop),
                      ),
                      const SizedBox(width: 48),
                      Expanded(
                        flex: 10,
                        child: _buildHeroRightVisual(context, isDesktop),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeroLeftContent(context, isDesktop),
                      const SizedBox(height: 48),
                      Center(
                        child: _buildHeroRightVisual(context, isDesktop),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget _buildHeroLeftContent(BuildContext context, bool isDesktop) {
    final titleStyle = isDesktop ? AppTypography.heroDisplay : AppTypography.heroDisplayMobile;
    final titleStyleLight = isDesktop ? AppTypography.heroDisplayLight : AppTypography.heroDisplayMobile.copyWith(fontWeight: FontWeight.w300);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StatusBadge(label: AppStrings.heroTag),
        const SizedBox(height: 24),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${AppStrings.heroTitleLine1} ${AppStrings.heroTitleLine2}\n",
                style: titleStyle,
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: ShaderMask(
                  shaderCallback: (bounds) =>
                      AppGradients.heroHighlightBluePurple.createShader(bounds),
                  child: Text(
                    "${AppStrings.heroHighlight1}\n",
                    style: titleStyle.copyWith(color: Colors.white),
                  ),
                ),
              ),
              TextSpan(
                text: "${AppStrings.heroHighlight2}\n",
                style: titleStyleLight,
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: ShaderMask(
                  shaderCallback: (bounds) =>
                      AppGradients.heroHighlightCyanBlue.createShader(bounds),
                  child: Text(
                    AppStrings.heroHighlight3,
                    style: titleStyle.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: const Text(
            AppStrings.heroBio,
            style: AppTypography.bodyLarge,
          ),
        ),
        const SizedBox(height: 36),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            AppGradientButton(
              text: AppStrings.viewProjects,
              icon: const Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white),
              onPressed: () => context.read<NavigationCubit>().scrollToSection('projects'),
            ),
            AppOutlineButton(
              text: AppStrings.contactMe,
              onPressed: () => context.read<NavigationCubit>().scrollToSection('contact'),
            ),
          ],
        ),
        const SizedBox(height: 36),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            AppIconButton(
              iconGlyph: "⑂",
              label: "GitHub",
              onPressed: () => UrlHelper.openUrl(AppConstants.githubUrl),
            ),
            AppIconButton(
              iconGlyph: "◉",
              label: "LinkedIn",
              onPressed: () => UrlHelper.openUrl(AppConstants.linkedinUrl),
            ),
            AppIconButton(
              iconGlyph: "↓",
              label: "CV",
              onPressed: () => UrlHelper.openUrl(AppConstants.cvDownloadUrl),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroRightVisual(BuildContext context, bool isDesktop) {
    return SizedBox(
      height: isDesktop ? 480 : 380,
      width: isDesktop ? 480 : 340,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: isDesktop ? 400 : 280,
            height: isDesktop ? 400 : 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.18),
                  AppColors.purple.withValues(alpha: 0.1),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 0.75],
              ),
            ),
          ),
          Container(
            width: isDesktop ? 360 : 260,
            height: isDesktop ? 360 : 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
          ),
          CodeEditorWindow(
            width: isDesktop ? 300 : 260,
          ),
          Positioned(
            left: isDesktop ? 16 : 8,
            top: isDesktop ? 32 : 16,
            child: _buildFloatingBadge("⬡", "Flutter", AppColors.primary),
          ),
          Positioned(
            right: isDesktop ? 16 : 8,
            top: isDesktop ? 48 : 24,
            child: _buildFloatingBadge("🔥", "Firebase", const Color(0xFFFF9100)),
          ),
          Positioned(
            right: isDesktop ? 20 : 8,
            bottom: isDesktop ? 54 : 24,
            child: _buildFloatingBadge("◆", "Dart", AppColors.cyan),
          ),
          Positioned(
            left: isDesktop ? 24 : 8,
            bottom: isDesktop ? 40 : 20,
            child: _buildFloatingBadge("⑂", "Git", const Color(0xFFF05032)),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingBadge(String iconGlyph, String label, Color accentColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.95),
        borderRadius: AppDecorations.radiusMd,
        border: Border.all(color: accentColor.withValues(alpha: 0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            iconGlyph,
            style: TextStyle(
              fontSize: 14,
              color: accentColor,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTypography.badgePill.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
