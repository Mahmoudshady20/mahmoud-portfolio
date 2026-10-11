import 'package:flutter/material.dart';
import '../../../../core/widgets/portfolio_ui.dart';
import '../widgets/project_case_study.dart';
import '../../domain/entities/project_entity.dart';
import '../sections/12_footer/footer_section.dart';

class ProjectDetailPage extends StatelessWidget {
  final ProjectEntity project;
  const ProjectDetailPage({super.key, required this.project});
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(
      backgroundColor: paper,
      title: Text(project.title),
      leading: IconButton(
        tooltip: 'Back to portfolio',
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (Navigator.canPop(c)) {
            Navigator.pop(c);
          } else {
            Navigator.pushNamedAndRemoveUntil(c, '/', (_) => false);
          }
        },
      ),
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProjectOverviewSection(project: project),
          ProjectEngineeringSection(project: project),
          const FooterSection(),
        ],
      ),
    ),
  );
}
