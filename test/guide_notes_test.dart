import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:mahmoud_portfolio/app/app.dart';
import 'package:mahmoud_portfolio/core/animations/pointer_parallax.dart';
import 'package:mahmoud_portfolio/core/animations/scroll_reveal.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/pages/project_detail_page.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/widgets/guide_note.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  VisibilityDetectorController.instance.updateInterval = Duration.zero;

  Future<void> start(
    WidgetTester tester, {
    Size size = const Size(1440, 1000),
    bool reduced = false,
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await initDependencies();
    await tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(size: size, disableAnimations: reduced),
        child: const MahmoudPortfolioApp(),
      ),
    );
    for (var frame = 0; frame < 20; frame++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  testWidgets('Mahmoud walks the visitor through every featured project', (
    tester,
  ) async {
    await start(tester);
    // One distinct walkthrough note per featured project card.
    expect(find.byType(GuideNote), findsAtLeastNWidgets(5));
    expect(
      find.textContaining('about three months after development began'),
      findsOneWidget,
    );
    expect(
      find.textContaining('designed its modular architecture'),
      findsOneWidget,
    );
    expect(find.textContaining('offline fallback'), findsOneWidget);
    expect(
      find.textContaining('split-screen review experience'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Case study pages carry the walkthrough too', (tester) async {
    await start(tester);
    final context = tester.element(find.text('Mahmoud Shady').first);
    Navigator.of(context).pushNamed('/projects/rejeemat');
    for (var frame = 0; frame < 20; frame++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.byType(ProjectDetailPage), findsOneWidget);
    expect(
      find.textContaining('about three months after development began'),
      findsOneWidget,
    );
    expect(find.textContaining('the problems I owned'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Walkthrough notes are present immediately with reduced motion', (
    tester,
  ) async {
    await start(tester, reduced: true);
    expect(find.byType(GuideNote), findsAtLeastNWidgets(5));
    expect(tester.takeException(), isNull);
  });

  testWidgets('ScrollReveal avoids opacity layers after the entrance', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 300,
            height: 300,
            child: ScrollReveal(child: Text('settled child')),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(VisibilityDetector), findsOneWidget);
    // Entrance finished: no visibility measuring or opacity layer remains.
    for (var frame = 0; frame < 12; frame++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.text('settled child'), findsOneWidget);
    final inside = find.byType(ScrollReveal);
    expect(
      find.descendant(of: inside, matching: find.byType(VisibilityDetector)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: inside, matching: find.byType(Opacity)),
      findsNothing,
    );
    expect(
      find.descendant(of: inside, matching: find.byType(Transform)),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Reduced motion renders the bare child immediately', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: Scaffold(body: ScrollReveal(child: Text('bare child'))),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('bare child'), findsOneWidget);
    expect(find.byType(VisibilityDetector), findsOneWidget);
    expect(find.byType(Opacity), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Pointer parallax reacts to the visitor and to reduced motion', (
    tester,
  ) async {
    const tracked = Key('tracked layer');
    Widget subject({bool reduced = false}) => MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(disableAnimations: reduced),
        child: const Scaffold(
          body: SizedBox(
            width: 400,
            height: 400,
            child: PointerParallax(
              child: ParallaxLayer(
                strength: 20,
                child: SizedBox(key: tracked, width: 100, height: 100),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpWidget(subject());
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    addTearDown(mouse.removePointer);
    await mouse.addPointer(location: const Offset(10, 10));
    await mouse.moveTo(const Offset(396, 396));
    await tester.pump();
    final moved = tester.getTopLeft(find.byKey(tracked));
    expect(moved, isNot(const Offset(0, 0)));
    // Reduced motion: no tracking, no offset, child renders bare.
    await tester.pumpWidget(subject(reduced: true));
    await tester.pump();
    final parallax = find.byType(PointerParallax);
    expect(
      find.descendant(of: parallax, matching: find.byType(MouseRegion)),
      findsNothing,
    );
    expect(
      find.descendant(of: parallax, matching: find.byType(Transform)),
      findsNothing,
    );
    expect(tester.takeException(), isNull);
  });
}
