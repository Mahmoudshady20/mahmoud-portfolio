import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/animations/animated_counter.dart';
import 'package:mahmoud_portfolio/core/animations/scroll_reveal.dart';
import 'package:mahmoud_portfolio/core/animations/stagger_animation.dart';
import 'package:mahmoud_portfolio/core/constants/app_strings.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/core/responsive/breakpoints.dart';
import 'package:mahmoud_portfolio/core/responsive/responsive_builder.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_decorations.dart';
import 'package:mahmoud_portfolio/core/theme/app_gradients.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';
import 'package:mahmoud_portfolio/core/widgets/cards/glass_card.dart';
import 'package:mahmoud_portfolio/core/widgets/section_header.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/entities/stat_entity.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';

class ImpactSection extends StatelessWidget {
  const ImpactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final impactStats = sl<PortfolioRepository>().getImpactStats();

    return ResponsiveBuilder(
      builder: (context, screenType) {
        final isMobile = screenType.isMobile;
        final isTablet = screenType.isTablet;

        int crossAxisCount = 6;
        double childAspectRatio = 1.08;

        if (isMobile) {
          crossAxisCount = 2;
          childAspectRatio = 1.05;
        } else if (isTablet) {
          crossAxisCount = 3;
          childAspectRatio = 1.2;
        }

        return Container(
          decoration: const BoxDecoration(
            gradient: AppGradients.impactBackground,
          ),
          padding: EdgeInsets.symmetric(vertical: isMobile ? 48 : 80),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SectionHeader(
                    tag: AppStrings.tagImpact,
                    tagColor: AppColors.purple,
                    titlePrefix: AppStrings.impactTitlePrefix,
                    titleHighlight: AppStrings.impactTitleHighlight,
                    isCentered: true,
                  ),
                  const SizedBox(height: 48),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: impactStats.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (context, index) {
                      final stat = impactStats[index];
                      return ScrollReveal(
                        delay: staggerDelay(index, interval: const Duration(milliseconds: 60)),
                        offsetY: 20,
                        child: _buildImpactCard(stat, isMobile),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImpactCard(StatEntity stat, bool isMobile) {
    return GlassCard(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      borderRadius: AppDecorations.radiusXl,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (bounds) =>
                AppGradients.heroHighlightBluePurple.createShader(bounds),
            child: AnimatedCounter(
              value: stat.value,
              style: TextStyle(
                fontFamily: AppTypography.fontPrimary,
                fontSize: isMobile ? 26 : 30,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              duration: const Duration(milliseconds: 900),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            stat.label,
            style: const TextStyle(
              fontFamily: AppTypography.fontMono,
              fontSize: 12,
              color: Color(0x73E8EDF5),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
