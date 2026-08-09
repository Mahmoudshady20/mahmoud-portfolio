import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/constants/app_strings.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/core/responsive/breakpoints.dart';
import 'package:mahmoud_portfolio/core/responsive/responsive_builder.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_decorations.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';
import 'package:mahmoud_portfolio/core/widgets/cards/glass_card.dart';
import 'package:mahmoud_portfolio/core/widgets/section_header.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/entities/testimonial_entity.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final testimonials = sl<PortfolioRepository>().getTestimonials();

    return ResponsiveBuilder(
      builder: (context, screenType) {
        final isMobile = screenType.isMobile;
        final isTablet = screenType.isTablet;

        int crossAxisCount = 3;
        if (isMobile) {
          crossAxisCount = 1;
        } else if (isTablet) {
          crossAxisCount = 2;
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
                  tag: AppStrings.tagTestimonials,
                  titlePrefix: AppStrings.testimonialsTitlePrefix,
                  titleHighlight: AppStrings.testimonialsTitleHighlight,
                  isCentered: true,
                ),
                const SizedBox(height: 64),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: testimonials.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: isMobile ? 1.35 : 1.08,
                  ),
                  itemBuilder: (context, index) {
                    final item = testimonials[index];
                    final accentColor = _getAvatarColor(index);
                    return _buildTestimonialCard(item, accentColor);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getAvatarColor(int index) {
    switch (index) {
      case 0:
        return AppColors.primary;
      case 1:
        return AppColors.purple;
      case 2:
      default:
        return AppColors.cyan;
    }
  }

  Widget _buildTestimonialCard(TestimonialEntity item, Color accentColor) {
    return GlassCard(
      padding: const EdgeInsets.all(28),
      borderRadius: AppDecorations.radiusXl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quote Mark
          Text(
            "\"",
            style: TextStyle(
              fontFamily: AppTypography.fontPrimary,
              fontSize: 30,
              fontWeight: FontWeight.w400,
              color: accentColor.withValues(alpha: 0.4),
              height: 1.0,
            ),
          ),
          const SizedBox(height: 14),

          // Quote Text
          Expanded(
            child: Text(
              item.quote,
              style: TextStyle(
                fontFamily: AppTypography.fontPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.8,
                color: const Color(0x99E8EDF5), // rgba(232, 237, 245, 0.6)
              ),
              overflow: TextOverflow.fade,
            ),
          ),
          const SizedBox(height: 16),

          // Author Info Row with divider line
          Container(
            padding: const EdgeInsets.only(top: 14),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.borderFaint, width: 1)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        accentColor,
                        accentColor.withValues(alpha: 0.53),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      item.initials,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.authorName,
                        style: TextStyle(
                          fontFamily: AppTypography.fontPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textWhite,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.authorRole,
                        style: TextStyle(
                          fontFamily: AppTypography.fontPrimary,
                          fontSize: 12,
                          color: const Color(0x66E8EDF5), // rgba(232, 237, 245, 0.4)
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
