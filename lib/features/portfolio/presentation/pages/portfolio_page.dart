import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/widgets/portfolio_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/navigation_cubit.dart';
import '../sections/01_header/mobile_drawer.dart';
import '../sections/01_header/navigation_bar.dart';
import '../sections/02_hero/hero_section.dart';
import '../sections/04_about/about_section.dart';
import '../sections/05_experience/experience_section.dart';
import '../sections/06_skills/skills_section.dart';
import '../sections/07_projects/projects_section.dart';
import '../sections/10_education/education_section.dart';
import '../sections/11_contact/contact_section.dart';
import '../sections/12_footer/footer_section.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});
  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext c) {
    final nav = c.read<NavigationCubit>();
    return Scaffold(
      key: scaffoldKey,
      endDrawer: const MobileDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: nav.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.textScalerOf(c).scale(17) > 27 ? 108 : 84,
                ),
                for (final (key, widget) in <(String, Widget)>[
                  ('home', const HeroSection()),
                  ('projects', const ProjectsSection()),
                  ('about', const AboutSection()),
                  ('experience', const ExperienceSection()),
                  ('skills', const SkillsSection()),
                  ('education', const EducationSection()),
                  ('contact', const ContactSection()),
                ])
                  RepaintBoundary(
                    child: SizedBox(
                      key: nav.sectionKeys[key],
                      width: double.infinity,
                      child: widget,
                    ),
                  ),
                const FooterSection(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomNavigationBar(scaffoldKey: scaffoldKey),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: MediaQuery.textScalerOf(c).scale(17) > 27 ? 106 : 82,
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: nav.scrollController,
                builder: (c, _) {
                  final controller = nav.scrollController;
                  final progress =
                      controller.hasClients &&
                          controller.position.maxScrollExtent > 0
                      ? (controller.offset /
                                controller.position.maxScrollExtent)
                            .clamp(0.0, 1.0)
                      : 0.0;
                  return LinearProgressIndicator(
                    value: progress,
                    minHeight: 2,
                    backgroundColor: Colors.transparent,
                    color: accent,
                    semanticsLabel: 'Page reading progress',
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
