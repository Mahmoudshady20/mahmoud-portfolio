import 'package:equatable/equatable.dart';

class NavigationState extends Equatable {
  final String activeSection;
  final bool isScrolled;
  final bool isDrawerOpen;

  const NavigationState({
    this.activeSection = 'home',
    this.isScrolled = false,
    this.isDrawerOpen = false,
  });

  NavigationState copyWith({
    String? activeSection,
    bool? isScrolled,
    bool? isDrawerOpen,
  }) {
    return NavigationState(
      activeSection: activeSection ?? this.activeSection,
      isScrolled: isScrolled ?? this.isScrolled,
      isDrawerOpen: isDrawerOpen ?? this.isDrawerOpen,
    );
  }

  @override
  List<Object?> get props => [activeSection, isScrolled, isDrawerOpen];
}
