import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/constants/app_constants.dart';
import 'package:mahmoud_portfolio/core/constants/app_strings.dart';
import 'package:mahmoud_portfolio/core/responsive/breakpoints.dart';
import 'package:mahmoud_portfolio/core/responsive/responsive_builder.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_decorations.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';
import 'package:mahmoud_portfolio/core/utils/url_helper.dart';
import 'package:mahmoud_portfolio/core/widgets/buttons/app_gradient_button.dart';
import 'package:mahmoud_portfolio/core/widgets/buttons/app_outline_button.dart';
import 'package:mahmoud_portfolio/core/widgets/cards/glass_card.dart';
import 'package:mahmoud_portfolio/core/widgets/section_header.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                  tag: AppStrings.tagContact,
                  titlePrefix: AppStrings.contactTitlePrefix,
                  titleHighlight: AppStrings.contactTitleHighlight,
                  subtitle: AppStrings.contactSubtitle,
                  isCentered: true,
                ),
                const SizedBox(height: 56),

                // Contact Cards Grid / Wrap
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildContactCard(
                      icon: Icons.email_rounded,
                      title: "Email",
                      value: AppConstants.email,
                      isMobile: isMobile,
                      onTap: () => UrlHelper.sendEmail(AppConstants.email),
                    ),
                    _buildContactCard(
                      icon: Icons.code_rounded,
                      title: "GitHub",
                      value: "github.com/mahmoudshady20",
                      isMobile: isMobile,
                      onTap: () => UrlHelper.openUrl(AppConstants.githubUrl),
                    ),
                    _buildContactCard(
                      icon: Icons.work_rounded,
                      title: "LinkedIn",
                      value: "linkedin.com/in/mahmoudshady",
                      isMobile: isMobile,
                      onTap: () => UrlHelper.openUrl(AppConstants.linkedinUrl),
                    ),
                    _buildContactCard(
                      icon: Icons.location_on_rounded,
                      title: "Location",
                      value: AppConstants.location,
                      isMobile: isMobile,
                      onTap: null,
                    ),
                  ],
                ),
                const SizedBox(height: 48),

                // Direct Action Buttons
                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    AppGradientButton(
                      text: "Send Message / Email",
                      icon: const Icon(
                        Icons.send_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      onPressed: () => UrlHelper.sendEmail(
                        AppConstants.email,
                        subject: "Flutter Project Inquiry",
                      ),
                    ),
                    AppOutlineButton(
                      text: "Download Resume",
                      icon: const Icon(
                        Icons.download_rounded,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      onPressed: () =>
                          UrlHelper.openUrl(AppConstants.cvDownloadUrl),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String value,
    required bool isMobile,
    VoidCallback? onTap,
  }) {
    return GlassCard(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 20,
        vertical: 16,
      ),
      borderRadius: AppDecorations.radiusXl,
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isMobile ? 280 : 320),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: AppDecorations.radiusSm,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: AppTypography.fontMono,
                      fontSize: 12,
                      color: const Color(0x73E8EDF5),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      fontFamily: AppTypography.fontPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textWhite,
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
    );
  }
}
