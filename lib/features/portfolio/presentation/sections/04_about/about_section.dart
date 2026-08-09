import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/constants/app_strings.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/core/responsive/breakpoints.dart';
import 'package:mahmoud_portfolio/core/responsive/responsive_builder.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_decorations.dart';
import 'package:mahmoud_portfolio/core/theme/app_gradients.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final aboutSkills = sl<PortfolioRepository>().getAboutSkills();

    return ResponsiveBuilder(
      builder: (context, screenType) {
        final isDesktop = screenType.isDesktop;
        final isMobile = screenType.isMobile;

        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: isDesktop ? 112 : (isMobile ? 48 : 80),
            ),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 10,
                        child: _buildCodeMockupCard(),
                      ),
                      const SizedBox(width: 80),
                      Expanded(
                        flex: 12,
                        child: _buildAboutTextContent(aboutSkills, isDesktop, isMobile),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAboutTextContent(aboutSkills, isDesktop, isMobile),
                      const SizedBox(height: 48),
                      Center(child: _buildCodeMockupCard()),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget _buildCodeMockupCard() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 451),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.glassSurface,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        border: Border.all(color: AppColors.borderSubtle, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 100,
            offset: const Offset(0, 30),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: AppDecorations.radiusLg,
              border: Border.all(color: AppColors.borderFaint),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _codeLine("import 'package:flutter/material.dart';", AppColors.syntaxControl),
                _codeLine("import 'package:flutter_bloc/flutter_bloc.dart';", AppColors.syntaxControl),
                const SizedBox(height: 12),
                _codeLine("class MyApp extends StatelessWidget {", AppColors.syntaxKeyword),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: _codeLine("final String title = \"Flutter Dev\";", AppColors.syntaxVariable),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: _codeLine("Widget build(BuildContext context) {", AppColors.syntaxFunction),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: _codeLine("return MaterialApp(", AppColors.syntaxType),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: _codeLine("theme: AppTheme.dark,", AppColors.syntaxVariable),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: _codeLine("home: HomeScreen(),", AppColors.syntaxString),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: _codeLine(");", AppColors.textPrimary),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: _codeLine("}", AppColors.textPrimary),
                ),
                _codeLine("}", AppColors.textPrimary),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _AboutPill(label: "Clean Arch"),
              _AboutPill(label: "MVVM"),
              _AboutPill(label: "SOLID"),
              _AboutPill(label: "Firebase"),
              _AboutPill(label: "Bloc"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _codeLine(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: AppTypography.fontMono,
          fontSize: 12,
          color: color,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildAboutTextContent(List<String> skills, bool isDesktop, bool isMobile) {
    final titleStyle = isDesktop ? AppTypography.h2 : AppTypography.h2Mobile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.tagAbout,
          style: AppTypography.sectionTag,
        ),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            style: titleStyle,
            children: [
              const TextSpan(text: "Crafting elegant code\n"),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: ShaderMask(
                  shaderCallback: (bounds) =>
                      AppGradients.sectionHighlight.createShader(bounds),
                  child: Text(
                    "one widget at a time.",
                    style: titleStyle.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          AppStrings.aboutParagraph1,
          style: AppTypography.bodyMedium.copyWith(
            height: 1.8,
            color: const Color(0x8CE8EDF5),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.aboutParagraph2,
          style: AppTypography.bodyMedium.copyWith(
            height: 1.8,
            color: const Color(0x73E8EDF5),
          ),
        ),
        const SizedBox(height: 32),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: skills.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 2 : 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: isMobile ? 3.0 : 3.6,
          ),
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.glassSurface,
                borderRadius: AppDecorations.radiusSm,
                border: Border.all(color: AppColors.borderSubtle),
              ),
              child: Text(
                skills[index],
                style: const TextStyle(
                  fontFamily: AppTypography.fontMono,
                  fontSize: 12,
                  color: Color(0x99E8EDF5),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _AboutPill extends StatelessWidget {
  final String label;

  const _AboutPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: AppDecorations.radiusPill,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: AppTypography.fontMono,
          fontSize: 12,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
