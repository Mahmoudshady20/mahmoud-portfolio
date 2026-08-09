import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/core/responsive/breakpoints.dart';
import 'package:mahmoud_portfolio/core/responsive/responsive_builder.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_decorations.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';
import 'package:mahmoud_portfolio/core/widgets/cards/glass_card.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/entities/stat_entity.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = sl<PortfolioRepository>().getHeaderStats();

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
            border: Border(
              top: BorderSide(color: AppColors.borderFaint, width: 1),
              bottom: BorderSide(color: AppColors.borderFaint, width: 1),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: isMobile ? 36 : 64),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: stats.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: childAspectRatio,
                ),
                itemBuilder: (context, index) {
                  final stat = stats[index];
                  return _buildStatCard(stat, isMobile);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard(StatEntity stat, bool isMobile) {
    return GlassCard(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      borderRadius: AppDecorations.radiusXl,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            stat.iconGlyph,
            style: TextStyle(
              fontSize: isMobile ? 20 : 22,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            stat.value,
            style: AppTypography.statNumber.copyWith(
              fontSize: isMobile ? 22 : 24,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            stat.label,
            style: AppTypography.statLabel,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
