import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahmoud_portfolio/core/widgets/portfolio_ui.dart';
import 'package:mahmoud_portfolio/core/constants/app_constants.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';
import '../../cubit/navigation_cubit.dart';
import '../../cubit/navigation_state.dart';

class CustomNavigationBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CustomNavigationBar({super.key, required this.scaffoldKey});
  @override
  Widget build(BuildContext c) => BlocBuilder<NavigationCubit, NavigationState>(
    buildWhen: (a, b) =>
        a.activeSection != b.activeSection || a.isScrolled != b.isScrolled,
    builder: (c, s) => Container(
      height: MediaQuery.textScalerOf(c).scale(17) > 27 ? 108 : 84,
      decoration: BoxDecoration(
        color: paper.withValues(alpha: 0.98),
        border: Border(
          bottom: BorderSide(color: s.isScrolled ? line : Colors.transparent),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(c).width < 720 ? 24 : 48,
            ),
            child: Row(
              children: [
                Flexible(
                  fit:
                      MediaQuery.sizeOf(c).width >= 1200 &&
                          MediaQuery.textScalerOf(c).scale(14) <= 18
                      ? FlexFit.loose
                      : FlexFit.tight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () => c.read<NavigationCubit>().scrollToSection(
                      'home',
                      animated: PortfolioMotion.enabled(c),
                      topInset: MediaQuery.textScalerOf(c).scale(17) > 27
                          ? 108
                          : 84,
                    ),
                    child: const Text(
                      'Mahmoud Shady',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -.4,
                      ),
                    ),
                  ),
                ),
                if (MediaQuery.sizeOf(c).width >= 1200 &&
                    MediaQuery.textScalerOf(c).scale(14) <= 18)
                  const Spacer(),
                if (MediaQuery.sizeOf(c).width >= 1200 &&
                    MediaQuery.textScalerOf(c).scale(14) <= 18) ...[
                  for (final item in sl<PortfolioRepository>().getNavItems())
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: TextButton(
                        onPressed: () =>
                            c.read<NavigationCubit>().scrollToSection(
                              item.sectionKey,
                              animated: PortfolioMotion.enabled(c),
                              topInset:
                                  MediaQuery.textScalerOf(c).scale(17) > 27
                                  ? 108
                                  : 84,
                            ),
                        style: TextButton.styleFrom(
                          foregroundColor: s.activeSection == item.sectionKey
                              ? accent
                              : ink,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(item.label),
                            const SizedBox(height: 4),
                            AnimatedContainer(
                              duration: PortfolioMotion.duration(c),
                              width: s.activeSection == item.sectionKey
                                  ? 18
                                  : 0,
                              height: 2,
                              color: accent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(width: 16),
                  const PortfolioButton(
                    'LinkedIn',
                    url: AppConstants.linkedinUrl,
                  ),
                ] else
                  IconButton(
                    tooltip: 'Open navigation',
                    onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
                    icon: const Icon(Icons.menu_rounded),
                  ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
