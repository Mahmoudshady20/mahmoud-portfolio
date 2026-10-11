import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/widgets/portfolio_ui.dart';
import 'package:mahmoud_portfolio/core/widgets/project_artwork.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/core/animations/scroll_reveal.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/entities/project_entity.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});
  @override
  Widget build(BuildContext c) {
    final projects = sl<PortfolioRepository>().getProjects();
    return SectionFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Eyebrow('01 / Selected work'),
          const SizedBox(height: 18),
          const EditorialHeading('Complete products.\nSubstantial ownership.'),
          const SizedBox(height: 22),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              'A closer look at the applications I’ve engineered, the challenges behind them, and my responsibility for the mobile product.',
              style: prose(size: 17),
            ),
          ),
          const SizedBox(height: 42),
          LayoutBuilder(
            builder: (c, b) {
              final columns = b.maxWidth > 780 ? 2 : 1;
              final width = (b.maxWidth - (columns - 1) * 24) / columns;
              return Wrap(
                spacing: 24,
                runSpacing: 28,
                children: List.generate(
                  4,
                  (i) => SizedBox(
                    width: width,
                    child: ScrollReveal(
                      delay: Duration(milliseconds: 80 * (i % 2)),
                      child: _ProjectCard(projects[i]),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 56),
          const Eyebrow('More mobile engineering'),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (c, b) {
              final columns = b.maxWidth > 850 ? 3 : (b.maxWidth > 550 ? 2 : 1);
              final width = (b.maxWidth - (columns - 1) * 20) / columns;
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: projects
                    .skip(4)
                    .map(
                      (p) => SizedBox(
                        width: width,
                        child: HoverSurface(
                          onTap: () =>
                              Navigator.pushNamed(c, '/projects/${p.slug}'),
                          semanticLabel: 'Open ${p.title} case study',
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Eyebrow(p.category),
                                const SizedBox(height: 14),
                                Text(p.title, style: display(25)),
                                const SizedBox(height: 12),
                                Text(p.description, style: prose(size: 14)),
                                const SizedBox(height: 22),
                                const Text(
                                  'Explore case study ↗',
                                  style: TextStyle(
                                    color: accent,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectEntity p;
  const _ProjectCard(this.p);
  @override
  Widget build(BuildContext c) => HoverSurface(
    onTap: () => Navigator.pushNamed(c, '/projects/${p.slug}'),
    semanticLabel: 'Open ${p.title} case study',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
          child: ProjectArtwork(project: p),
        ),
        Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 18,
                runSpacing: 8,
                children: [Eyebrow(p.category), StatusLabel(p.status)],
              ),
              const SizedBox(height: 20),
              Text(p.heading, style: display(28)),
              const SizedBox(height: 16),
              Text(p.description, style: prose(size: 15)),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 16),
                decoration: const BoxDecoration(
                  border: Border(left: BorderSide(color: accent, width: 2)),
                ),
                child: Text(p.outcome, style: prose(size: 14, color: ink)),
              ),
              const SizedBox(height: 26),
              TechnologyLine(p.techStack.take(4).toList()),
              const SizedBox(height: 26),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Explore case study',
                      style: TextStyle(
                        color: accent,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_rounded, color: accent, size: 20),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
