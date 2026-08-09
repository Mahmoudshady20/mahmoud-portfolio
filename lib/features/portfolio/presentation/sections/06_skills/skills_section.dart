import 'package:flutter/material.dart';
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
import 'package:mahmoud_portfolio/features/portfolio/domain/entities/skill_entity.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
                    return ScrollReveal(
                      delay: staggerDelay(index, interval: const Duration(milliseconds: 50)),
                      offsetY: 16,
                      duration: const Duration(milliseconds: 350),
                      child: _AnimatedSkillCard(
                        skill: skill,
                        accentColor: accentColor,
                      ),
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
}

/// A skill card with an animated progress bar that fills when visible.
class _AnimatedSkillCard extends StatefulWidget {
  final SkillEntity skill;
  final Color accentColor;

  const _AnimatedSkillCard({
    required this.skill,
    required this.accentColor,
  });

  @override
  State<_AnimatedSkillCard> createState() => _AnimatedSkillCardState();
}

class _AnimatedSkillCardState extends State<_AnimatedSkillCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _barAnimation;
  late final Animation<double> _percentFadeAnimation;
  bool _hasAnimated = false;
  late final Key _visibilityKey;

  @override
  void initState() {
    super.initState();
    _visibilityKey = UniqueKey();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _barAnimation = Tween<double>(begin: 0.0, end: widget.skill.percentage / 100.0)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.75, curve: Curves.easeOutCubic),
    ));
    _percentFadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_hasAnimated) return;
    if (info.visibleFraction > 0.3) {
      _hasAnimated = true;
      if (mounted) _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: _onVisibilityChanged,
      child: GlassCard(
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
                    color: widget.accentColor.withValues(alpha: 0.08),
                    borderRadius: AppDecorations.radiusSm,
                    border: Border.all(
                      color: widget.accentColor.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.skill.iconGlyph,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.skill.name,
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
            // Animated progress bar
            Container(
              height: 3,
              decoration: BoxDecoration(
                color: const Color(0x12FFFFFF),
                borderRadius: BorderRadius.circular(2),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return AnimatedBuilder(
                    animation: _barAnimation,
                    builder: (context, child) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: constraints.maxWidth * _barAnimation.value,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                widget.accentColor,
                                widget.accentColor.withValues(alpha: 0.67),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 3),
            // Animated percentage text
            AnimatedBuilder(
              animation: _percentFadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _percentFadeAnimation.value,
                  child: child,
                );
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${widget.skill.percentage}%",
                  style: const TextStyle(
                    fontFamily: AppTypography.fontMono,
                    fontSize: 11,
                    color: Color(0x59E8EDF5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
