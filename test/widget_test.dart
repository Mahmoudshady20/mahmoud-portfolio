import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/sections/02_hero/hero_section.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mahmoud_portfolio/app/app.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';

void main() {
  ambientTests();
  TestWidgetsFlutterBinding.ensureInitialized();
  VisibilityDetectorController.instance.updateInterval = Duration.zero;
  testWidgets('Portfolio app smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await initDependencies();
    await tester.pumpWidget(const MahmoudPortfolioApp());
    await tester.pump();

    expect(find.text('Mahmoud Shady'), findsWidgets);
  });
}

void ambientTests() {
  testWidgets('Full app ambient changes', (tester) async {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    await initDependencies();
    await tester.pumpWidget(const MahmoudPortfolioApp());
    await tester.pump(const Duration(seconds: 2));
    final a = tester
        .widgetList<Transform>(
          find.descendant(
            of: find.byType(HeroAmbient),
            matching: find.byType(Transform),
          ),
        )
        .map((x) => x.transform.toString())
        .join();
    await tester.pump(const Duration(seconds: 3));
    final b = tester
        .widgetList<Transform>(
          find.descendant(
            of: find.byType(HeroAmbient),
            matching: find.byType(Transform),
          ),
        )
        .map((x) => x.transform.toString())
        .join();
    expect(a, isNot(b));
  });
  testWidgets(
    'Ambient hero moves, respects reduced motion, and disposes safely',
    (tester) async {
      VisibilityDetectorController.instance.updateInterval = Duration.zero;
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeroAmbient(child: SizedBox(width: 300, height: 400)),
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 1));
      final a = tester
          .widgetList<Transform>(find.byType(Transform))
          .map((x) => x.transform.toString())
          .join();
      await tester.pump(const Duration(seconds: 3));
      final b = tester
          .widgetList<Transform>(find.byType(Transform))
          .map((x) => x.transform.toString())
          .join();
      expect(a, isNot(b));
      await tester.pumpWidget(
        const MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(disableAnimations: true),
            child: HeroAmbient(child: SizedBox(width: 300, height: 400)),
          ),
        ),
      );
      await tester.pump();
      final x = tester
          .widgetList<Transform>(find.byType(Transform))
          .map((x) => x.transform.toString())
          .join();
      await tester.pump(const Duration(seconds: 3));
      final y = tester
          .widgetList<Transform>(find.byType(Transform))
          .map((x) => x.transform.toString())
          .join();
      expect(x, y);
      await tester.pumpWidget(const SizedBox());
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );
}
