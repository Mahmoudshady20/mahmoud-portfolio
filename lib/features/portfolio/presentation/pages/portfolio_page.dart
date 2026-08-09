import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/cubit/navigation_cubit.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/sections/01_header/mobile_drawer.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/sections/01_header/navigation_bar.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/sections/02_hero/hero_section.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/sections/03_stats/stats_section.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/sections/04_about/about_section.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/sections/05_experience/experience_section.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/sections/06_skills/skills_section.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/sections/07_projects/projects_section.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/sections/08_impact/impact_section.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/sections/09_certificates/certificates_section.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/sections/11_contact/contact_section.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/sections/12_footer/footer_section.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final navCubit = context.read<NavigationCubit>();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      endDrawer: const MobileDrawer(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: navCubit.scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 70),
                  RepaintBoundary(
                    child: SizedBox(
                      key: navCubit.sectionKeys['home'],
                      width: double.infinity,
                      child: const HeroSection(),
                    ),
                  ),
                  const RepaintBoundary(
                    child: SizedBox(width: double.infinity, child: StatsSection()),
                  ),
                  RepaintBoundary(
                    child: SizedBox(
                      key: navCubit.sectionKeys['about'],
                      width: double.infinity,
                      child: const AboutSection(),
                    ),
                  ),
                  RepaintBoundary(
                    child: SizedBox(
                      key: navCubit.sectionKeys['experience'],
                      width: double.infinity,
                      child: const ExperienceSection(),
                    ),
                  ),
                  RepaintBoundary(
                    child: SizedBox(
                      key: navCubit.sectionKeys['skills'],
                      width: double.infinity,
                      child: const SkillsSection(),
                    ),
                  ),
                  RepaintBoundary(
                    child: SizedBox(
                      key: navCubit.sectionKeys['projects'],
                      width: double.infinity,
                      child: const ProjectsSection(),
                    ),
                  ),
                  const RepaintBoundary(
                    child: SizedBox(
                      width: double.infinity,
                      child: ImpactSection(),
                    ),
                  ),
                  RepaintBoundary(
                    child: SizedBox(
                      key: navCubit.sectionKeys['certificates'],
                      width: double.infinity,
                      child: const CertificatesSection(),
                    ),
                  ),
                  RepaintBoundary(
                    child: SizedBox(
                      key: navCubit.sectionKeys['contact'],
                      width: double.infinity,
                      child: const ContactSection(),
                    ),
                  ),
                  const RepaintBoundary(
                    child: SizedBox(
                      width: double.infinity,
                      child: FooterSection(),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomNavigationBar(scaffoldKey: _scaffoldKey),
            ),
          ],
        ),
      ),
    );
  }
}
