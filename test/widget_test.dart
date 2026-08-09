import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mahmoud_portfolio/app/app.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';

void main() {
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
