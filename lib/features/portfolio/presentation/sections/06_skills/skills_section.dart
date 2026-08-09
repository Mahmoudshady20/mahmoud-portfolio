import 'package:flutter/material.dart';
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
import 'package:mahmoud_portfolio/features/portfolio/domain/entities/skill_entity.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = sl<PortfolioRepository>().getSkills();

    return ResponsiveBuilder(
      builder: (context, screenType) {
        final isMobile = screenType.isMobile;
        final isTablet = screenType.isTablet;

        int crossAxisCount = 4;
        double childAspectRatio = 2.15;

        if (isMobile) {
          crossAxisCount = 1;
          childAspectRatio = 3.2;
        } else if (isTablet) {
          crossAxisCount = 2;
          childAspectRatio = 2.7;
        }

        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: isMobile ? 48 : 112,
            ),
            child: Column(
              children: [
                const SectionHeader(
                  tag: AppStrings.tagSkills,
                  tagColor: AppColors.cyan,
                  titlePrefix: AppStrings.skillsTitlePrefix,
                  titleHighlight: AppStrings.skillsTitleHighlight,
                  highlightGradient: AppGradients.cyanBlueHighlight,
                  isCentered: true,
                ),
                const SizedBox(height: 64),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: skills.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemBuilder: (context, index) {
                    final skill = skills[index];
                    final accentColor = _getSkillColor(index);
                    return _buildSkillCard(skill, accentColor);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getSkillColor(int index) {
    switch (index % 4) {
      case 0:
        return AppColors.cyan;
      case 1:
        return AppColors.primary;
      case 2:
        return const Color(0xFFFFA000);
      case 3:
      default:
        return AppColors.purple;
    }
  }

  Widget _buildSkillCard(SkillEntity skill, Color accentColor) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      borderRadius: AppDecorations.radiusXl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.08),
                  borderRadius: AppDecorations.radiusSm,
                  border: Border.all(color: accentColor.withValues(alpha: 0.2)),
                ),
                child: Center(
                  child: Text(
                    skill.iconGlyph,
                    style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  skill.name,
                  style: TextStyle(
                    fontFamily: AppTypography.fontPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textWhite,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 3,
            decoration: BoxDecoration(
              color: const Color(0x12FFFFFF),
              borderRadius: BorderRadius.circular(2),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: constraints.maxWidth * (skill.percentage / 100.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          accentColor,
                          accentColor.withValues(alpha: 0.67),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 3),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "${skill.percentage}%",
              style: const TextStyle(
                fontFamily: AppTypography.fontMono,
                fontSize: 11,
                color: Color(0x59E8EDF5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
