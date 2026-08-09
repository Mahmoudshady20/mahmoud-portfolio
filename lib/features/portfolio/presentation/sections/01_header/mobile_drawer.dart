import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahmoud_portfolio/core/constants/app_constants.dart';
import 'package:mahmoud_portfolio/core/constants/app_strings.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_decorations.dart';
import 'package:mahmoud_portfolio/core/theme/app_gradients.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';
import 'package:mahmoud_portfolio/core/utils/url_helper.dart';
import 'package:mahmoud_portfolio/core/widgets/buttons/app_gradient_button.dart';
import 'package:mahmoud_portfolio/core/widgets/buttons/app_outline_button.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/cubit/navigation_cubit.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/cubit/navigation_state.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        final navItems = [
          {'label': AppStrings.navHome, 'key': 'home', 'icon': Icons.home_rounded},
          {'label': AppStrings.navAbout, 'key': 'about', 'icon': Icons.person_rounded},
          {'label': AppStrings.navExperience, 'key': 'experience', 'icon': Icons.work_rounded},
          {'label': AppStrings.navSkills, 'key': 'skills', 'icon': Icons.bolt_rounded},
          {'label': AppStrings.navProjects, 'key': 'projects', 'icon': Icons.code_rounded},
          {'label': AppStrings.navCertificates, 'key': 'certificates', 'icon': Icons.verified_rounded},
          {'label': AppStrings.navContact, 'key': 'contact', 'icon': Icons.mail_rounded},
        ];

        return Drawer(
          backgroundColor: AppColors.background,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              gradient: AppGradients.primaryButton,
                              borderRadius: AppDecorations.radiusSm,
                            ),
                            child: const Center(
                              child: Text(
                                AppConstants.developerInitials,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            AppConstants.developerName,
                            style: AppTypography.h4.copyWith(fontSize: 15),
                          ),
                        ],
                      ),
                      IconButton(
                        tooltip: "Close menu",
                        icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: AppColors.borderFaint),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      itemCount: navItems.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 6),
                      itemBuilder: (context, index) {
                        final item = navItems[index];
                        final isActive = state.activeSection == item['key'];

                        return Semantics(
                          button: true,
                          selected: isActive,
                          label: "Navigate to ${item['label']}",
                          child: ListTile(
                            leading: Icon(
                              item['icon'] as IconData,
                              color: isActive ? AppColors.primary : AppColors.textSecondary,
                              size: 20,
                            ),
                            title: Text(
                              item['label'] as String,
                              style: TextStyle(
                                fontFamily: AppTypography.fontPrimary,
                                fontSize: 15,
                                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                                color: isActive ? AppColors.primary : AppColors.textPrimary,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: AppDecorations.radiusSm,
                            ),
                            tileColor: isActive
                                ? AppColors.primary.withValues(alpha: 0.12)
                                : Colors.transparent,
                            onTap: () {
                              Navigator.of(context).pop();
                              context
                                  .read<NavigationCubit>()
                                  .scrollToSection(item['key'] as String);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppOutlineButton(
                    text: AppStrings.downloadCv,
                    height: 44,
                    onPressed: () {
                      Navigator.of(context).pop();
                      UrlHelper.openUrl(AppConstants.cvDownloadUrl);
                    },
                  ),
                  const SizedBox(height: 10),
                  AppGradientButton(
                    text: AppStrings.hireMe,
                    height: 44,
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.read<NavigationCubit>().scrollToSection('contact');
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
