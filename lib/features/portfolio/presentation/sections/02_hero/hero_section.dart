import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahmoud_portfolio/core/widgets/portfolio_ui.dart';
import 'package:mahmoud_portfolio/core/constants/app_constants.dart';
import 'package:mahmoud_portfolio/core/animations/scroll_reveal.dart';
import '../../cubit/navigation_cubit.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});
  @override
  Widget build(BuildContext c) => SectionFrame(
    vertical: MediaQuery.sizeOf(c).width < 720 ? 52 : 78,
    child: LayoutBuilder(
      builder: (c, b) {
        final wide = b.maxWidth > 850;
        final content = ScrollReveal(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Eyebrow(
                'Software Engineer · Mobile Applications',
                color: accent,
              ),
              const SizedBox(height: 28),
              Semantics(
                header: true,
                headingLevel: 1,
                child: Text(
                  'Complete apps.\nConsidered\nengineering.',
                  style: display(wide ? 74 : (b.maxWidth > 540 ? 64 : 46)),
                ),
              ),
              const SizedBox(height: 28),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 510),
                child: Text(
                  'I’m Mahmoud Shady. I turn business requirements into complete mobile applications — from architecture and implementation to integration, delivery, and everything that follows.',
                  style: prose(size: 18),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Flutter & Dart specialist. Building for iOS and Android.',
                style: prose(size: 14, color: ink),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  PortfolioButton(
                    'Explore selected work',
                    primary: true,
                    icon: Icons.arrow_downward_rounded,
                    onPressed: () => c.read<NavigationCubit>().scrollToSection(
                      'projects',
                      animated: PortfolioMotion.enabled(c),
                      topInset: MediaQuery.textScalerOf(c).scale(17) > 27
                          ? 108
                          : 84,
                    ),
                  ),
                  const PortfolioButton(
                    'Download resume',
                    url: AppConstants.cvDownloadUrl,
                  ),
                ],
              ),
              const SizedBox(height: 38),
              const Eyebrow('Cairo, Egypt / Architecture → Delivery'),
            ],
          ),
        );
        if (!wide) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              content,
              const SizedBox(height: 42),
              const _EngineeringComposition(),
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 6, child: content),
            const SizedBox(width: 46),
            const Expanded(
              flex: 4,
              child: ScrollReveal(
                delay: Duration(milliseconds: 150),
                child: _EngineeringComposition(),
              ),
            ),
          ],
        );
      },
    ),
  );
}

class _EngineeringComposition extends StatelessWidget {
  const _EngineeringComposition();
  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      color: const Color(0xffe4dbef),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Expanded(child: Eyebrow('The mobile lifecycle', color: ink)),
            Icon(Icons.north_east, size: 20),
          ],
        ),
        const SizedBox(height: 48),
        Text('Built as a whole.', style: display(35)),
        const SizedBox(height: 14),
        Text(
          'Architecture, application behavior, and delivery — connected.',
          style: prose(size: 15, color: ink),
        ),
        const SizedBox(height: 38),
        for (final (n, title, sub) in [
          (
            '01',
            'Understand & architect',
            'Requirements → maintainable structure',
          ),
          (
            '02',
            'Build & integrate',
            'Product experience → connected services',
          ),
          ('03', 'Test & deliver', 'Critical behavior → ongoing reliability'),
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: paper,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Eyebrow(n, color: accent),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ink,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(sub, style: prose(size: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 24),
        const Wrap(
          spacing: 24,
          runSpacing: 10,
          children: [Eyebrow('Flutter / Dart'), Eyebrow('iOS + Android')],
        ),
      ],
    ),
  );
}
