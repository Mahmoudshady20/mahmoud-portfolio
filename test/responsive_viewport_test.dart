import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mahmoud_portfolio/app/app.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';

void main() {
  setUpAll(() async {
    await initDependencies();
  });

  const testViewports = [
    Size(1440, 900),
    Size(1280, 800),
    Size(1024, 768),
    Size(768, 1024),
    Size(600, 900),
    Size(430, 932), // iPhone 15 Pro Max
    Size(390, 844), // iPhone 15 / 14 / 13 Pro
    Size(375, 667), // iPhone SE / Small screen
  ];

  for (final size in testViewports) {
    testWidgets('Responsive visual layout test at width ${size.width.toInt()}px',
        (WidgetTester tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const MahmoudPortfolioApp());
      await tester.pumpAndSettle();

      // Verify no exceptions were thrown and core brand elements render
      expect(find.text('Mahmoud Shady'), findsWidgets);
      expect(find.byType(SingleChildScrollView), findsWidgets);
    });
  }
}
