import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/di/injection_container.dart';
import '../core/theme/app_theme.dart';
import '../core/widgets/portfolio_ui.dart';
import '../features/portfolio/domain/repositories/portfolio_repository.dart';
import '../features/portfolio/presentation/cubit/navigation_cubit.dart';
import '../features/portfolio/presentation/pages/portfolio_page.dart';
import '../features/portfolio/presentation/pages/project_detail_page.dart';

class MahmoudPortfolioApp extends StatefulWidget {
  const MahmoudPortfolioApp({super.key});
  @override
  State<MahmoudPortfolioApp> createState() => _MahmoudPortfolioAppState();
}

class _MahmoudPortfolioAppState extends State<MahmoudPortfolioApp> {
  late final SemanticsHandle semanticsHandle;
  @override
  void initState() {
    super.initState();
    semanticsHandle = SemanticsBinding.instance.ensureSemantics();
  }

  @override
  void dispose() {
    semanticsHandle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext c) => BlocProvider<NavigationCubit>(
    create: (_) => sl<NavigationCubit>(),
    child: MaterialApp(
      title: 'Mahmoud Shady | Software & Mobile Application Engineer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateInitialRoutes: (name) => name == '/'
          ? [_route(const RouteSettings(name: '/'), c)]
          : [
              _route(const RouteSettings(name: '/'), c),
              _route(RouteSettings(name: name), c),
            ],
      onGenerateRoute: (settings) => _route(settings, c),
    ),
  );
  Route<dynamic> _route(RouteSettings settings, BuildContext c) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const PortfolioPage(),
      );
    }

    final name = settings.name ?? '/';
    if (name.startsWith('/projects/')) {
      final matches = sl<PortfolioRepository>().getProjects().where(
        (p) => p.slug == name.split('/').last,
      );
      if (matches.isNotEmpty) {
        return PageRouteBuilder(
          settings: settings,
          transitionDuration: PortfolioMotion.duration(c, 350),
          reverseTransitionDuration: PortfolioMotion.duration(c, 250),
          pageBuilder: (c, a, b) => ProjectDetailPage(project: matches.first),
          transitionsBuilder: (c, a, b, child) =>
              FadeTransition(opacity: a, child: child),
        );
      }
    }
    return MaterialPageRoute(
      settings: settings,
      builder: (pageContext) => Scaffold(
        body: SectionFrame(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const EditorialHeading('This page could not be found.'),
              const SizedBox(height: 24),
              PortfolioButton(
                'Return to portfolio',
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  pageContext,
                  '/',
                  (route) => false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
