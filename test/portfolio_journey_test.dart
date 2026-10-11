import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:mahmoud_portfolio/app/app.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/core/widgets/portfolio_ui.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/pages/project_detail_page.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/cubit/navigation_cubit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  VisibilityDetectorController.instance.updateInterval = Duration.zero;

  Future<void> start(
    WidgetTester tester, {
    Size size = const Size(1440, 1000),
    double scale = 1,
    bool reduced = false,
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await initDependencies();
    await tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(
          size: size,
          textScaler: TextScaler.linear(scale),
          disableAnimations: reduced,
        ),
        child: const MahmoudPortfolioApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('Verified employment and product boundaries remain accurate', (
    tester,
  ) async {
    await start(tester);
    final repo = sl<PortfolioRepository>();
    expect(repo.getExperiences().map((e) => '${e.role}|${e.company}|${e.period}'), [
      'Software Engineer | Mobile Developer|Tara Digital | Full Stack Digital Solutions|July 2025–present',
      'Flutter Developer|Upwork|September 2021–October 2025',
      'Software Engineer| Mobile Developer|Phlera Ltd.|December 2024–July 2025',
      'Flutter Developer|Shbbak Solution Group|October 2023–October 2024',
    ]);
    expect(repo.getProjects().map((p) => p.slug).toSet().length, 7);
    final hayah = repo.getProjects().first;
    expect(hayah.status, 'In development');
    expect(hayah.appStoreUrl, isNull);
    expect(hayah.githubUrl, isNull);
    expect(
      repo.getProjects()[1].outcome,
      contains('approximately three months'),
    );
    expect(repo.getProjects()[1].appStoreUrl, isNull);
    expect(repo.getEducation().length, 2);
    expect(
      repo.getEducation().first.degree,
      'Bachelor’s degree · Computer Science',
    );
    expect(repo.getEducation().first.period, 'September 2019 – September 2023');
    expect(repo.getCertificates(), isEmpty);
    expect(repo.getHeaderStats(), isEmpty);
  });

  for (final slug in [
    'hayah',
    'rejeemat',
    'rosy-calc',
    'qudratuh',
    'hub-spare-parts',
    'doa2k',
    'islami',
  ]) {
    testWidgets('$slug case study opens and returns to the portfolio', (
      tester,
    ) async {
      await start(tester);
      final context = tester.element(find.text('Mahmoud Shady').first);
      Navigator.of(context).pushNamed('/projects/$slug');
      await tester.pumpAndSettle();
      expect(find.byType(ProjectDetailPage), findsOneWidget);
      expect(find.text('The engineering challenge'), findsOneWidget);
      await tester.tap(find.byTooltip('Back to portfolio'));
      await tester.pumpAndSettle();
      expect(find.byType(ProjectDetailPage), findsNothing);
      expect(
        find.text('Complete apps.\nConsidered\nengineering.'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Mobile navigation reaches contact and closes the drawer', (
    tester,
  ) async {
    await start(tester, size: const Size(390, 844));
    await tester.tap(find.byTooltip('Open navigation'));
    await tester.pumpAndSettle();
    expect(find.text('Navigation'.toUpperCase()), findsOneWidget);
    await tester.tap(find.text('Contact').last);
    await tester.pumpAndSettle();
    expect(find.byTooltip('Close navigation'), findsNothing);
    final contact = tester
        .getTopLeft(find.text('Good products start\nwith a conversation.'))
        .dy;
    expect(contact, inInclusiveRange(80, 280));
  });

  for (final size in [
    const Size(320, 700),
    const Size(390, 844),
    const Size(1440, 1000),
  ]) {
    testWidgets('Large text and reduced motion at ${size.width}', (
      tester,
    ) async {
      await start(tester, size: size, scale: 2, reduced: true);
      final context = tester.element(find.byType(HoverSurface).first);
      expect(MediaQuery.textScalerOf(context).scale(14), 28);
      expect(PortfolioMotion.enabled(context), isFalse);
      expect(PortfolioMotion.duration(context), Duration.zero);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Keyboard activation opens mobile navigation', (tester) async {
    await start(tester, size: const Size(390, 844));
    Focus.of(tester.element(find.byIcon(Icons.menu_rounded))).requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(find.byTooltip('Close navigation'), findsOneWidget);
  });

  testWidgets('Rapid navigation retains the latest requested section', (
    tester,
  ) async {
    await start(tester);
    final nav = tester
        .element(find.text('Mahmoud Shady').first)
        .read<NavigationCubit>();
    nav.scrollToSection('skills');
    nav.scrollToSection('contact');
    await tester.pumpAndSettle();
    expect(nav.state.activeSection, 'contact');
    expect(tester.takeException(), isNull);
  });

  testWidgets('Direct case-study URL returns directly to the portfolio', (
    tester,
  ) async {
    tester.binding.platformDispatcher.defaultRouteNameTestValue =
        '/projects/hayah';
    addTearDown(
      tester.binding.platformDispatcher.clearDefaultRouteNameTestValue,
    );
    await start(tester);
    expect(find.byType(ProjectDetailPage), findsOneWidget);
    await tester.tap(find.byTooltip('Back to portfolio'));
    await tester.pumpAndSettle();
    expect(
      find.text('Complete apps.\nConsidered\nengineering.'),
      findsOneWidget,
    );
    expect(find.text('This page could not be found.'), findsNothing);
  });
}
