import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahmoud_portfolio/core/widgets/portfolio_ui.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/core/constants/app_constants.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';
import '../../cubit/navigation_cubit.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});
  @override
  Widget build(BuildContext c) => Drawer(
    backgroundColor: paper,
    width: MediaQuery.sizeOf(c).width.clamp(280, 380) - 24,
    child: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Eyebrow('Navigation'),
                  const Spacer(),
                  IconButton(
                    tooltip: 'Close navigation',
                    onPressed: () => Navigator.pop(c),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              for (final item in sl<PortfolioRepository>().getNavItems())
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(c);
                      c.read<NavigationCubit>().scrollToSection(
                        item.sectionKey,
                        animated: PortfolioMotion.enabled(c),
                        topInset: MediaQuery.textScalerOf(c).scale(17) > 27
                            ? 108
                            : 84,
                      );
                    },
                    child: Text(item.label, style: display(30)),
                  ),
                ),
              const SizedBox(height: 30),
              const PortfolioButton(
                'Download resume',
                url: AppConstants.cvDownloadUrl,
                primary: true,
              ),
              const SizedBox(height: 14),
              const PortfolioButton('LinkedIn', url: AppConstants.linkedinUrl),
            ],
          ),
        ),
      ),
    ),
  );
}
