import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/widgets/portfolio_ui.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/core/animations/scroll_reveal.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});
  @override
  Widget build(BuildContext c) {
    final skills = sl<PortfolioRepository>().getSkills();
    return SectionFrame(
      background: const Color(0xffebe9e2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Eyebrow('04 / Technical expertise'),
          const SizedBox(height: 18),
          const EditorialHeading('Capabilities first.\nTools with a purpose.'),
          const SizedBox(height: 24),
          Text(
            'Engineering practices and technologies I use to build, connect, test, and maintain complete mobile applications.',
            style: prose(size: 17),
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (c, b) {
              final columns = b.maxWidth > 800 ? 3 : (b.maxWidth > 530 ? 2 : 1);
              final width = (b.maxWidth - (columns - 1) * 22) / columns;
              return Wrap(
                spacing: 22,
                runSpacing: 22,
                children: List.generate(skills.length, (i) {
                  final s = skills[i];
                  return SizedBox(
                    width: width,
                    child: ScrollReveal(
                      delay: Duration(milliseconds: 60 * (i % columns)),
                      child: Container(
                        padding: const EdgeInsets.all(26),
                        decoration: BoxDecoration(
                          color: paper,
                          border: Border.all(color: line),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Eyebrow('0${i + 1}', color: accent),
                            const SizedBox(height: 30),
                            Text(s.name, style: display(23)),
                            const SizedBox(height: 18),
                            Text(s.description, style: prose(size: 14)),
                            const SizedBox(height: 22),
                            Text(
                              s.technologies.join(' · '),
                              style: prose(size: 12, color: ink),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
