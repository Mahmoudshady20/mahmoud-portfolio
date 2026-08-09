import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  final ScrollController scrollController = ScrollController();
  final Map<String, GlobalKey> sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'experience': GlobalKey(),
    'projects': GlobalKey(),
    'skills': GlobalKey(),
    'certificates': GlobalKey(),
    'testimonials': GlobalKey(),
    'contact': GlobalKey(),
  };

  NavigationCubit() : super(const NavigationState()) {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final isScrolled = scrollController.hasClients && scrollController.offset > 50;
    if (isScrolled != state.isScrolled) {
      emit(state.copyWith(isScrolled: isScrolled));
    }
  }

  void setActiveSection(String sectionKey) {
    if (state.activeSection != sectionKey) {
      emit(state.copyWith(activeSection: sectionKey));
    }
  }

  void scrollToSection(String sectionKey) {
    setActiveSection(sectionKey);
    final key = sectionKeys[sectionKey];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
        alignment: 0.0,
      );
    }
  }

  void toggleDrawer({bool? open}) {
    emit(state.copyWith(isDrawerOpen: open ?? !state.isDrawerOpen));
  }

  @override
  Future<void> close() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    return super.close();
  }
}
