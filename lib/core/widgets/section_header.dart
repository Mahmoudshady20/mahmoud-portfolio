import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/animations/scroll_reveal.dart';
import 'package:mahmoud_portfolio/core/responsive/responsive_builder.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_gradients.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';

class SectionHeader extends StatelessWidget {
  final String tag;
  final String titlePrefix;
  final String titleHighlight;
  final String? subtitle;
  final bool isCentered;
  final Color? tagColor;
  final Gradient? highlightGradient;

  const SectionHeader({
    super.key,
    required this.tag,
    required this.titlePrefix,
    required this.titleHighlight,
    this.subtitle,
    this.isCentered = true,
    this.tagColor,
    this.highlightGradient,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, screenType) {
        final isMobile = screenType.isMobile;
        final titleStyle = isMobile ? AppTypography.h2Mobile : AppTypography.h2;

        return Column(
          crossAxisAlignment:
              isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            // Tag with slight delay
            ScrollReveal(
              offsetY: 14,
              duration: const Duration(milliseconds: 350),
              child: Text(
                tag,
                style: AppTypography.sectionTag.copyWith(
                  color: tagColor ?? AppColors.primary,
                ),
                textAlign: isCentered ? TextAlign.center : TextAlign.start,
              ),
            ),
            const SizedBox(height: 12),
            // Title with stagger
            ScrollReveal(
              delay: const Duration(milliseconds: 60),
              offsetY: 14,
              duration: const Duration(milliseconds: 350),
              child: RichText(
                textAlign: isCentered ? TextAlign.center : TextAlign.start,
                text: TextSpan(
                  style: titleStyle,
                  children: [
                    TextSpan(text: titlePrefix),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: ShaderMask(
                        shaderCallback: (bounds) =>
                            (highlightGradient ?? AppGradients.sectionHighlight)
                                .createShader(bounds),
                        child: Text(
                          titleHighlight,
                          style: titleStyle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 12),
              ScrollReveal(
                delay: const Duration(milliseconds: 120),
                offsetY: 10,
                duration: const Duration(milliseconds: 350),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(
                    subtitle!,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSubtle,
                    ),
                    textAlign: isCentered ? TextAlign.center : TextAlign.start,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
