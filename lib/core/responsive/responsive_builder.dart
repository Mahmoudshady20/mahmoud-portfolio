import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/responsive/breakpoints.dart';
import 'package:mahmoud_portfolio/core/responsive/screen_type.dart';

typedef ResponsiveWidgetBuilder = Widget Function(
  BuildContext context,
  ScreenType screenType,
);

class ResponsiveBuilder extends StatelessWidget {
  final ResponsiveWidgetBuilder builder;
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
    this.mobile,
    this.tablet,
    this.desktop,
  });

  static ScreenType getScreenType(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= Breakpoints.desktopMin) {
      return ScreenType.desktop;
    } else if (width >= Breakpoints.tabletMin) {
      return ScreenType.tablet;
    } else {
      return ScreenType.mobile;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenType = getScreenType(context);
        return builder(context, screenType);
      },
    );
  }
}
