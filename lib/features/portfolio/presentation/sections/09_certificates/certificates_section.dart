import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/constants/app_strings.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/core/responsive/responsive_builder.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_decorations.dart';
import 'package:mahmoud_portfolio/core/theme/app_gradients.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';
import 'package:mahmoud_portfolio/core/utils/url_helper.dart';
import 'package:mahmoud_portfolio/core/widgets/cards/glass_card.dart';
import 'package:mahmoud_portfolio/core/widgets/section_header.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/entities/certificate_entity.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';

class CertificatesSection extends StatelessWidget {
  const CertificatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final certificates = sl<PortfolioRepository>().getCertificates();

    return ResponsiveBuilder(
      builder: (context, screenType) {
        final isMobile = screenType.isMobile;
        final isDesktop = screenType.isDesktop;

        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1024),
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: isMobile ? 48 : 112,
            ),
            child: Column(
              children: [
                const SectionHeader(
                  tag: AppStrings.tagCertificates,
                  tagColor: AppColors.cyan,
                  titlePrefix: AppStrings.certificatesTitlePrefix,
                  titleHighlight: AppStrings.certificatesTitleHighlight,
                  highlightGradient: AppGradients.cyanBlueHighlight,
                  isCentered: true,
                ),
                const SizedBox(height: 64),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: certificates.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isDesktop ? 2 : 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: isDesktop ? 2.9 : (isMobile ? 2.6 : 4.0),
                  ),
                  itemBuilder: (context, index) {
                    final cert = certificates[index];
                    final accentColor = _getCertColor(index);
                    return _buildCertificateCard(cert, accentColor);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getCertColor(int index) {
    switch (index) {
      case 0:
        return AppColors.primary;
      case 1:
        return AppColors.purple;
      case 2:
        return AppColors.cyan;
      case 3:
      default:
        return AppColors.green;
    }
  }

  Widget _buildCertificateCard(CertificateEntity cert, Color accentColor) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      borderRadius: AppDecorations.radiusXl,
      onTap: cert.url != null ? () => UrlHelper.openUrl(cert.url!) : null,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: accentColor.withValues(alpha: 0.2)),
            ),
            child: Center(
              child: Text(
                "✦",
                style: TextStyle(fontSize: 18, color: accentColor),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cert.title,
                  style: TextStyle(
                    fontFamily: AppTypography.fontPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textWhite,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  cert.issuer,
                  style: TextStyle(
                    fontFamily: AppTypography.fontPrimary,
                    fontSize: 12,
                    color: const Color(0x73E8EDF5),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.08),
                    borderRadius: AppDecorations.radiusPill,
                    border: Border.all(color: accentColor.withValues(alpha: 0.18)),
                  ),
                  child: Text(
                    cert.year,
                    style: TextStyle(
                      fontFamily: AppTypography.fontMono,
                      fontSize: 11,
                      color: accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "→",
            style: TextStyle(
              fontSize: 18,
              color: accentColor.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
