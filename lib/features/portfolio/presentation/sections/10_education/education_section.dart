import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/widgets/portfolio_ui.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});
  @override
  Widget build(BuildContext c) => SectionFrame(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Eyebrow('05 / Education'),
        const SizedBox(height: 18),
        const EditorialHeading('A foundation\nin computer science.'),
        const SizedBox(height: 36),
        for (final education in sl<PortfolioRepository>().getEducation())
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: line)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(education.school, style: display(23)),
                const SizedBox(height: 8),
                Text(education.degree, style: prose(size: 16, color: ink)),
                const SizedBox(height: 8),
                Eyebrow(education.period),
              ],
            ),
          ),
      ],
    ),
  );
}
