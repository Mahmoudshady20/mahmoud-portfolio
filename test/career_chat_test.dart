import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mahmoud_portfolio/app/app.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/widgets/career_chat.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  VisibilityDetectorController.instance.updateInterval = Duration.zero;

  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await initDependencies();
    await tester.pumpWidget(const MahmoudPortfolioApp());
    await tester.pump();
  }

  testWidgets('Career chat opens and answers from portfolio facts', (
    tester,
  ) async {
    await pumpApp(tester);
    expect(find.byType(CareerChat), findsOneWidget);

    await tester.tap(find.text('Ask about my career'));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Answers come from this portfolio only'), findsOneWidget);

    await tester.enterText(
      find.byType(TextField),
      'Where does he work now?',
    );
    await tester.testTextInput.receiveAction(TextInputAction.send);
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.textContaining('Tara Digital'), findsWidgets);
    expect(find.text('Go to experience'), findsWidgets);
  });

  testWidgets('Career chat falls back on unknown questions', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Ask about my career'));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 400));

    await tester.enterText(find.byType(TextField), 'quantum computing?');
    await tester.testTextInput.receiveAction(TextInputAction.send);
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.textContaining('I can only share'), findsOneWidget);
  });

  testWidgets('Career chat names a project and offers its case study', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.tap(find.text('Ask about my career'));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 400));

    await tester.enterText(find.byType(TextField), 'Tell me about Hayah');
    await tester.testTextInput.receiveAction(TextInputAction.send);
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.textContaining('Hayah'), findsWidgets);
    expect(find.text('Open the Hayah case study'), findsOneWidget);
  });
}
