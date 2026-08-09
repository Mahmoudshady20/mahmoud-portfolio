enum ScreenType {
  mobile,
  tablet,
  desktop;

  bool get isMobile => this == ScreenType.mobile;
  bool get isTablet => this == ScreenType.tablet;
  bool get isDesktop => this == ScreenType.desktop;
}
