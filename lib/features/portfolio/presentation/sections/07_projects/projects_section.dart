import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/animations/scroll_reveal.dart';
import 'package:mahmoud_portfolio/core/animations/stagger_animation.dart';
import 'package:mahmoud_portfolio/core/constants/app_strings.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/core/responsive/breakpoints.dart';
import 'package:mahmoud_portfolio/core/responsive/responsive_builder.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';
import 'package:mahmoud_portfolio/core/utils/url_helper.dart';
import 'package:mahmoud_portfolio/core/widgets/buttons/app_gradient_button.dart';
import 'package:mahmoud_portfolio/core/widgets/buttons/app_outline_button.dart';
import 'package:mahmoud_portfolio/core/widgets/cards/glass_card.dart';
import 'package:mahmoud_portfolio/core/widgets/mockups/mobile_device_frame.dart';
import 'package:mahmoud_portfolio/core/widgets/pills/tech_pill.dart';
import 'package:mahmoud_portfolio/core/widgets/section_header.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/entities/project_entity.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = sl<PortfolioRepository>().getProjects();

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
                  tag: AppStrings.tagProjects,
                  titlePrefix: AppStrings.projectsTitlePrefix,
                  titleHighlight: AppStrings.projectsTitleHighlight,
                  subtitle: AppStrings.projectsSubtitle,
                  isCentered: true,
                ),
                const SizedBox(height: 64),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: projects.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 48),
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    final isReversed = index.isOdd;
                    return ScrollReveal(
                      delay: staggerDelay(index, interval: const Duration(milliseconds: 100)),
                      duration: const Duration(milliseconds: 500),
                      offsetY: 30,
                      child: _buildProjectCard(project, isReversed, isMobile),
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

  Widget _buildProjectCard(ProjectEntity project, bool isReversed, bool isMobile) {
    final mockupWidget = Center(
      child: MobileDeviceFrame(
        title: project.title,
        category: project.category,
      ),
    );

    final detailsWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Number / Featured tag
        Text(
          "${project.number} — Featured Project",
          style: AppTypography.badgeMono,
        ),
        const SizedBox(height: 12),

        // Title
        Text(
          project.title,
          style: isMobile ? AppTypography.h3 : AppTypography.h2,
        ),
        const SizedBox(height: 6),

        // Category
        Text(
          project.category,
          style: const TextStyle(
            fontFamily: AppTypography.fontPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0x73E8EDF5),
          ),
        ),
        const SizedBox(height: 16),

        // Description
        Text(
          project.description,
          style: AppTypography.bodyMedium.copyWith(
            color: const Color(0x80E8EDF5),
            height: 1.7,
          ),
        ),
        const SizedBox(height: 20),

        // Bullet Features
        Wrap(
          spacing: 16,
          runSpacing: 10,
          children: project.features.map((f) {
            return Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: "✦  ",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 10,
                    ),
                  ),
                  TextSpan(
                    text: f,
                    style: const TextStyle(
                      fontFamily: AppTypography.fontPrimary,
                      fontSize: 12,
                      color: Color(0x80E8EDF5),
                    ),
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          }).toList(),
        ),
        const SizedBox(height: 24),

        // Tech stack tags
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.techStack.map((t) => TechPill(label: t, isAccent: true)).toList(),
        ),
        const SizedBox(height: 28),

        // Action buttons
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            if (project.liveDemoUrl != null)
              AppGradientButton(
                text: AppStrings.liveDemo,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                onPressed: () => UrlHelper.openUrl(project.liveDemoUrl!),
              ),
            if (project.githubUrl != null)
              AppOutlineButton(
                text: AppStrings.github,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                onPressed: () => UrlHelper.openUrl(project.githubUrl!),
              ),
            if (project.playStoreUrl != null)
              AppOutlineButton(
                text: AppStrings.playStore,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onPressed: () => UrlHelper.openUrl(project.playStoreUrl!),
              ),
            if (project.appStoreUrl != null)
              AppOutlineButton(
                text: AppStrings.appStore,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onPressed: () => UrlHelper.openUrl(project.appStoreUrl!),
              ),
          ],
        ),
      ],
    );

    return GlassCard(
      padding: EdgeInsets.all(isMobile ? 20 : 40),
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mockupWidget,
                const SizedBox(height: 28),
                detailsWidget,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: isReversed
                  ? [
                      Expanded(flex: 12, child: detailsWidget),
                      const SizedBox(width: 48),
                      Expanded(flex: 10, child: mockupWidget),
                    ]
                  : [
                      Expanded(flex: 10, child: mockupWidget),
                      const SizedBox(width: 48),
                      Expanded(flex: 12, child: detailsWidget),
                    ],
            ),
    );
  }
}
