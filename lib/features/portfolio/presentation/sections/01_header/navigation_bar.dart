import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahmoud_portfolio/core/constants/app_constants.dart';
import 'package:mahmoud_portfolio/core/constants/app_strings.dart';
import 'package:mahmoud_portfolio/core/responsive/breakpoints.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_decorations.dart';
import 'package:mahmoud_portfolio/core/theme/app_gradients.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';
import 'package:mahmoud_portfolio/core/utils/url_helper.dart';
import 'package:mahmoud_portfolio/core/widgets/buttons/app_gradient_button.dart';
import 'package:mahmoud_portfolio/core/widgets/buttons/app_outline_button.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/cubit/navigation_cubit.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/cubit/navigation_state.dart';

class CustomNavigationBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomNavigationBar({
    super.key,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= Breakpoints.desktopMin;

    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 70,
          decoration: BoxDecoration(
            color: state.isScrolled
                ? AppColors.background.withValues(alpha: 0.9)
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: state.isScrolled ? AppColors.borderSubtle : Colors.transparent,
                width: 1,
              ),
            ),
          ),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLogo(context),
                  if (isDesktop) ...[
                    const SizedBox(width: 16),
                    Expanded(
                      child: Center(
                        child: _buildNavItems(context, state),
                      ),
                    ),
                    const SizedBox(width: 16),
                    _buildActions(context),
                  ] else ...[
                    Semantics(
                      button: true,
                      label: "Open Navigation Menu",
                      child: IconButton(
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: AppColors.textPrimary,
                          size: 28,
                        ),
                        onPressed: () {
                          scaffoldKey.currentState?.openEndDrawer();
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Semantics(
      button: true,
      label: "Mahmoud Shady Portfolio Home",
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => context.read<NavigationCubit>().scrollToSection('home'),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  gradient: AppGradients.primaryButton,
                  borderRadius: AppDecorations.radiusSm,
                  boxShadow: AppDecorations.primaryGlowShadow,
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
                style: AppTypography.h4.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItems(BuildContext context, NavigationState state) {
    final navItems = [
      {'label': AppStrings.navHome, 'key': 'home'},
      {'label': AppStrings.navAbout, 'key': 'about'},
      {'label': AppStrings.navExperience, 'key': 'experience'},
      {'label': AppStrings.navProjects, 'key': 'projects'},
      {'label': AppStrings.navSkills, 'key': 'skills'},
      {'label': AppStrings.navCertificates, 'key': 'certificates'},
      {'label': AppStrings.navTestimonials, 'key': 'testimonials'},
      {'label': AppStrings.navContact, 'key': 'contact'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: navItems.map((item) {
          final isActive = state.activeSection == item['key'];
          return _NavItemButton(
            label: item['label']!,
            isActive: isActive,
            onTap: () => context.read<NavigationCubit>().scrollToSection(item['key']!),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppOutlineButton(
          text: AppStrings.downloadCv,
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          onPressed: () => UrlHelper.openUrl(AppConstants.cvDownloadUrl),
        ),
        const SizedBox(width: 10),
        AppGradientButton(
          text: AppStrings.hireMe,
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          onPressed: () => context.read<NavigationCubit>().scrollToSection('contact'),
        ),
      ],
    );
  }
}

class _NavItemButton extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItemButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItemButton> createState() => _NavItemButtonState();
}

class _NavItemButtonState extends State<_NavItemButton> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: true,
      selected: widget.isActive,
      label: "Navigate to ${widget.label} section",
      child: FocusableActionDetector(
        mouseCursor: SystemMouseCursors.click,
        onShowHoverHighlight: (val) => setState(() => _isHovered = val),
        onShowFocusHighlight: (val) => setState(() => _isFocused = val),
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) => widget.onTap(),
          ),
          ButtonActivateIntent: CallbackAction<ButtonActivateIntent>(
            onInvoke: (_) => widget.onTap(),
          ),
        },
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: widget.isActive
                  ? AppColors.primary.withValues(alpha: 0.12)
                  : ((_isHovered || _isFocused) ? AppColors.glassSurfaceHover : Colors.transparent),
              borderRadius: AppDecorations.radiusSm,
              border: _isFocused
                  ? Border.all(color: AppColors.primary, width: 1.5)
                  : null,
            ),
            child: Text(
              widget.label,
              style: TextStyle(
                fontFamily: AppTypography.fontPrimary,
                fontSize: 13.5,
                fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w500,
                color: widget.isActive
                    ? AppColors.primary
                    : ((_isHovered || _isFocused) ? AppColors.textWhite : AppColors.textSecondary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
