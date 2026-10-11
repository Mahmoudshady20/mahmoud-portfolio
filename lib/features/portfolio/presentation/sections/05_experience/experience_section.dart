import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/widgets/portfolio_ui.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/core/animations/scroll_reveal.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});
  @override
  Widget build(BuildContext c) => SectionFrame(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Eyebrow('03 / Professional experience'),
        const SizedBox(height: 18),
        const EditorialHeading('The work behind\nthe work.'),
        const SizedBox(height: 42),
        for (final e in sl<PortfolioRepository>().getExperiences())
          ScrollReveal(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: line)),
              ),
              child: LayoutBuilder(
                builder: (c, b) {
                  final detail = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.role, style: display(25)),
                      const SizedBox(height: 8),
                      Text(e.company, style: prose(size: 16, color: accent)),
                      const SizedBox(height: 18),
                      for (final bullet in e.description.split('\n').take(3))
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(bullet, style: prose(size: 14)),
                        ),
                    ],
                  );
                  return b.maxWidth > 720
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 245, child: Eyebrow(e.period)),
                            Expanded(child: detail),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Eyebrow(e.period),
                            const SizedBox(height: 18),
                            detail,
                          ],
                        );
                },
              ),
            ),
          ),
        const SizedBox(height: 22),
        const PortfolioButton(
          'Full experience in my resume',
          url: 'resume/Mahmoud-Shady-Resume.pdf',
        ),
      ],
    ),
  );
}
