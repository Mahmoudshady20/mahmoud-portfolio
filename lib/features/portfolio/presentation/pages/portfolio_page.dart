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
import 'package:mahmoud_portfolio/features/portfolio/presentation/sections/10_testimonials/testimonials_section.dart';
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
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: navCubit.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 70),
                Container(
                  key: navCubit.sectionKeys['home'],
                  child: const HeroSection(),
                ),
                const StatsSection(),
                Container(
                  key: navCubit.sectionKeys['about'],
                  child: const AboutSection(),
                ),
                Container(
                  key: navCubit.sectionKeys['experience'],
                  child: const ExperienceSection(),
                ),
                Container(
                  key: navCubit.sectionKeys['skills'],
                  child: const SkillsSection(),
                ),
                Container(
                  key: navCubit.sectionKeys['projects'],
                  child: const ProjectsSection(),
                ),
                const ImpactSection(),
                Container(
                  key: navCubit.sectionKeys['certificates'],
                  child: const CertificatesSection(),
                ),
                Container(
                  key: navCubit.sectionKeys['testimonials'],
                  child: const TestimonialsSection(),
                ),
                Container(
                  key: navCubit.sectionKeys['contact'],
                  child: const ContactSection(),
                ),
                const FooterSection(),
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
    );
  }
}
