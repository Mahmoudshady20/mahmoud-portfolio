import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/constants/app_strings.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/core/responsive/breakpoints.dart';
import 'package:mahmoud_portfolio/core/responsive/responsive_builder.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_decorations.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';
import 'package:mahmoud_portfolio/core/widgets/pills/tech_pill.dart';
import 'package:mahmoud_portfolio/core/widgets/section_header.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/entities/experience_entity.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final experiences = sl<PortfolioRepository>().getExperiences();

    return ResponsiveBuilder(
      builder: (context, screenType) {
        final isMobile = screenType.isMobile;

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
                  tag: AppStrings.tagExperience,
                  tagColor: AppColors.purple,
                  titlePrefix: AppStrings.experienceTitlePrefix,
                  titleHighlight: AppStrings.experienceTitleHighlight,
                  isCentered: true,
                ),
                const SizedBox(height: 64),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: experiences.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 32),
                  itemBuilder: (context, index) {
                    final exp = experiences[index];
                    final accentColor = index == 0
                        ? AppColors.primary
                        : (index == 1 ? AppColors.purple : AppColors.cyan);
                    return _buildExperienceCard(exp, accentColor, isMobile);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExperienceCard(ExperienceEntity exp, Color accentColor, bool isMobile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Milestone Badge (64x64 on desktop)
        Container(
          width: isMobile ? 48 : 64,
          height: isMobile ? 48 : 64,
          decoration: BoxDecoration(
            color: AppColors.glassSurface,
            borderRadius: AppDecorations.radiusXl,
            border: Border.all(
              color: accentColor.withValues(alpha: 0.25),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: accentColor.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              exp.number,
              style: TextStyle(
                fontFamily: AppTypography.fontPrimary,
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w700,
                color: accentColor,
              ),
            ),
          ),
        ),
        SizedBox(width: isMobile ? 16 : 24),

        // Experience Card with Left Accent Bar
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.glassSurface,
              borderRadius: AppDecorations.radiusXl,
              border: Border.all(color: AppColors.borderSubtle, width: 1),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width: 3,
                  child: Container(
                    color: accentColor.withValues(alpha: 0.7),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isMobile) ...[
                        Text(
                          exp.role,
                          style: AppTypography.h4.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          exp.company,
                          style: TextStyle(
                            fontFamily: AppTypography.fontPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: accentColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildDatePill(exp.period, accentColor),
                      ] else ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exp.role,
                                    style: AppTypography.h4.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    exp.company,
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontPrimary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: accentColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            _buildDatePill(exp.period, accentColor),
                          ],
                        ),
                      ],
                      const SizedBox(height: 16),
                      Text(
                        exp.description,
                        style: AppTypography.bodyMedium.copyWith(
                          color: const Color(0x80E8EDF5),
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: exp.technologies.map((t) => TechPill(label: t)).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePill(String period, Color accentColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.08),
        borderRadius: AppDecorations.radiusPill,
        border: Border.all(
          color: accentColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Text(
        period,
        style: TextStyle(
          fontFamily: AppTypography.fontMono,
          fontSize: 12,
          color: accentColor,
        ),
      ),
    );
  }
}
