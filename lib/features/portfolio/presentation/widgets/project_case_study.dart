import 'package:flutter/material.dart';
import '../../../../core/widgets/portfolio_ui.dart';
import '../../../../core/widgets/project_artwork.dart';
import '../../../../core/animations/scroll_reveal.dart';
import '../../domain/entities/project_entity.dart';

class ProjectOverviewSection extends StatelessWidget {
  final ProjectEntity project;
  const ProjectOverviewSection({super.key, required this.project});
  @override
  Widget build(BuildContext c) => SectionFrame(
    vertical: 58,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Eyebrow('${project.number} / ${project.category}'),
        const SizedBox(height: 22),
        EditorialHeading(project.heading, level: 1),
        const SizedBox(height: 24),
        StatusLabel(project.status),
        const SizedBox(height: 32),
        ProjectArtwork(
          project: project,
          large: MediaQuery.sizeOf(c).width > 720,
        ),
        const SizedBox(height: 36),
        Text(project.description, style: prose(size: 20, color: ink)),
        const SizedBox(height: 26),
        TechnologyLine(project.techStack),
      ],
    ),
  );
}

class ProjectEngineeringSection extends StatelessWidget {
  final ProjectEntity project;
  const ProjectEngineeringSection({super.key, required this.project});
  @override
  Widget build(BuildContext c) => SectionFrame(
    background: const Color(0xffebe9e2),
    child: ScrollReveal(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Eyebrow('Mobile engineering ownership'),
          const SizedBox(height: 20),
          Text(project.ownership, style: prose(size: 19, color: ink)),
          const SizedBox(height: 40),
          const EditorialHeading('The engineering challenge'),
          const SizedBox(height: 24),
          Text(project.challenge, style: prose(size: 18)),
          const SizedBox(height: 40),
          const EditorialHeading('My responsibilities'),
          const SizedBox(height: 24),
          for (final responsibility in project.features)
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Icon(Icons.north_east, size: 18, color: accent),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Text(
                      responsibility,
                      style: prose(size: 16, color: ink),
                    ),
                  ),
                ],
              ),
            ),
          if (project.features.isEmpty)
            Text(project.outcome, style: prose(size: 16)),
          const SizedBox(height: 32),
          const EditorialHeading('Delivery & current status'),
          const SizedBox(height: 24),
          Text(project.outcome, style: prose(size: 18, color: ink)),
          if (project.slug == 'hayah') ...[
            const SizedBox(height: 14),
            Text(
              'Under active development. The application has not been released; further features and production validation remain in progress.',
              style: prose(size: 16),
            ),
          ],
          const SizedBox(height: 32),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              if (project.playStoreUrl != null)
                PortfolioButton(
                  'View on Google Play',
                  url: project.playStoreUrl,
                  primary: true,
                ),
              if (project.appStoreUrl != null)
                PortfolioButton(
                  'View on the App Store',
                  url: project.appStoreUrl,
                  primary: true,
                ),
              const PortfolioButton(
                'Discuss mobile engineering',
                url: 'mailto:mahmoud4ady@gmail.com',
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
