import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/widgets/portfolio_ui.dart';
import 'package:mahmoud_portfolio/core/widgets/project_artwork.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/core/animations/scroll_reveal.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/entities/project_entity.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';
import '../../widgets/guide_note.dart';

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
          const SizedBox(height: 28),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: const GuideNote(
              'Let me walk you through my work. Each of these is a mobile product I engineered — open any of them and I’ll show you what it is, what I built, and the hard parts I owned.',
            ),
          ),
          const SizedBox(height: 42),
          LayoutBuilder(
            builder: (c, b) {
              final columns = b.maxWidth > 780 ? 2 : 1;
              return EqualHeightGrid(
                columns: columns,
                children: List.generate(
                  4,
                  (i) => ScrollReveal(
                    delay: Duration(milliseconds: 110 * (i % columns)),
                    child: _ProjectCard(projects[i]),
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
              return EqualHeightGrid(
                columns: columns,
                children: projects.skip(4).toList().asMap().entries.map((
                  entry,
                ) {
                  final p = entry.value;
                  return ScrollReveal(
                    delay: Duration(milliseconds: 100 * entry.key),
                    child: HoverSurface(
                      onTap: () =>
                          Navigator.pushNamed(c, '/projects/${p.slug}'),
                      semanticLabel: 'Open ${p.title} case study',
                      child: Padding(
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Eyebrow(p.category),
                            const SizedBox(height: 16),
                            Text(p.title, style: display(25)),
                            const SizedBox(height: 16),
                            Text(p.description, style: prose(size: 14)),
                            const SizedBox(height: 24),
                            const Spacer(),
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
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectEntity p;
  const _ProjectCard(this.p);
  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool hovered = false;
  @override
  Widget build(BuildContext c) {
    final p = widget.p;
    final motion = PortfolioMotion.enabled(c);
    return HoverSurface(
      onTap: () => Navigator.pushNamed(c, '/projects/${p.slug}'),
      semanticLabel: 'Open ${p.title} case study',
      onHoverChanged: (value) => setState(() => hovered = value),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(21)),
            child: SizedBox(
              height:
                  MediaQuery.sizeOf(c).width > 900 &&
                      MediaQuery.textScalerOf(c).scale(14) < 20
                  ? 340
                  : null,
              // Transform-only scale: the artwork answers the hover without
              // repainting anything outside its own layer.
              child: RepaintBoundary(
                child: AnimatedScale(
                  scale: hovered && motion ? 1.045 : 1,
                  duration: const Duration(milliseconds: 320),
                  curve: Curves.easeOutCubic,
                  child: ProjectArtwork(project: p),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
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
                  const SizedBox(height: 22),
                  ProjectWalkthrough(
                    slug: p.slug,
                    challenge: p.challenge,
                    outcome: p.outcome,
                  ),
                  const SizedBox(height: 26),
                  TechnologyLine(p.techStack.take(4).toList()),
                  const Spacer(),
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
                      AnimatedSlide(
                        offset: hovered && motion
                            ? const Offset(0.22, 0)
                            : Offset.zero,
                        duration: const Duration(milliseconds: 240),
                        curve: Curves.easeOutCubic,
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: accent,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
