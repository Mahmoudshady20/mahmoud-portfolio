import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/animations/scroll_reveal.dart';
import 'package:mahmoud_portfolio/core/animations/stagger_animation.dart';
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
            constraints: const BoxConstraints(
              maxWidth: Breakpoints.maxContentWidth,
            ),
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
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 32),
                  itemBuilder: (context, index) {
                    final exp = experiences[index];
                    final accentColor = index == 0
                        ? AppColors.primary
                        : (index == 1 ? AppColors.purple : AppColors.cyan);
                    return ScrollReveal(
                      delay: staggerDelay(index, interval: const Duration(milliseconds: 80)),
                      duration: const Duration(milliseconds: 450),
                      offsetY: 24,
                      child: _buildExperienceCard(exp, accentColor, isMobile),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExperienceCard(
    ExperienceEntity exp,
    Color accentColor,
    bool isMobile,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Milestone Badge with scale-bounce entrance
        _AnimatedMilestoneBadge(
          number: exp.number,
          accentColor: accentColor,
          isMobile: isMobile,
        ),
        SizedBox(width: isMobile ? 16 : 24),

        // Experience Card with animated accent bar
        Expanded(
          child: _AnimatedExperienceCard(
            exp: exp,
            accentColor: accentColor,
            isMobile: isMobile,
          ),
        ),
      ],
    );
  }
}

/// Milestone badge with a scale-bounce entrance animation.
class _AnimatedMilestoneBadge extends StatefulWidget {
  final String number;
  final Color accentColor;
  final bool isMobile;

  const _AnimatedMilestoneBadge({
    required this.number,
    required this.accentColor,
    required this.isMobile,
  });

  @override
  State<_AnimatedMilestoneBadge> createState() =>
      _AnimatedMilestoneBadgeState();
}

class _AnimatedMilestoneBadgeState extends State<_AnimatedMilestoneBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    // Delay slightly to sync with parent ScrollReveal
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: Container(
        width: widget.isMobile ? 48 : 64,
        height: widget.isMobile ? 48 : 64,
        decoration: BoxDecoration(
          color: AppColors.glassSurface,
          borderRadius: AppDecorations.radiusXl,
          border: Border.all(
            color: widget.accentColor.withValues(alpha: 0.25),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.accentColor.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.number,
            style: TextStyle(
              fontFamily: AppTypography.fontPrimary,
              fontSize: widget.isMobile ? 14 : 16,
              fontWeight: FontWeight.w700,
              color: widget.accentColor,
            ),
          ),
        ),
      ),
    );
  }
}

/// Experience card with an animated left accent bar.
class _AnimatedExperienceCard extends StatefulWidget {
  final ExperienceEntity exp;
  final Color accentColor;
  final bool isMobile;

  const _AnimatedExperienceCard({
    required this.exp,
    required this.accentColor,
    required this.isMobile,
  });

  @override
  State<_AnimatedExperienceCard> createState() =>
      _AnimatedExperienceCardState();
}

class _AnimatedExperienceCardState extends State<_AnimatedExperienceCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _barController;
  late final Animation<double> _barAnimation;

  @override
  void initState() {
    super.initState();
    _barController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _barAnimation = CurvedAnimation(
      parent: _barController,
      curve: Curves.easeOutCubic,
    );
    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) _barController.forward();
    });
  }

  @override
  void dispose() {
    _barController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exp = widget.exp;
    final accentColor = widget.accentColor;
    final isMobile = widget.isMobile;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.glassSurface,
        borderRadius: AppDecorations.radiusXl,
        border: Border.all(color: AppColors.borderSubtle, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Animated accent bar
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 3,
            child: AnimatedBuilder(
              animation: _barAnimation,
              builder: (context, child) {
                return FractionallySizedBox(
                  heightFactor: _barAnimation.value,
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: accentColor.withValues(alpha: 0.7),
                  ),
                );
              },
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
                  children: exp.technologies
                      .map((t) => TechPill(label: t))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePill(String period, Color accentColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.08),
        borderRadius: AppDecorations.radiusPill,
        border: Border.all(color: accentColor.withValues(alpha: 0.2), width: 1),
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
