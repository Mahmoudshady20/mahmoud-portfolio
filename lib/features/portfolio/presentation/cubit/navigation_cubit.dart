import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  final ScrollController scrollController = ScrollController();

  final Map<String, GlobalKey> sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'experience': GlobalKey(),
    'skills': GlobalKey(),
    'projects': GlobalKey(),
    'certificates': GlobalKey(),
    'testimonials': GlobalKey(),
    'contact': GlobalKey(),
  };

  bool _isAutoScrolling = false;

  NavigationCubit() : super(const NavigationState()) {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    final offset = scrollController.offset;
    final isScrolled = offset > 40;

    if (isScrolled != state.isScrolled) {
      emit(state.copyWith(isScrolled: isScrolled));
    }

    // Skip recalculation during programmatic scroll animations
    if (_isAutoScrolling) return;

    _updateActiveSectionOnScroll();
  }

  void _updateActiveSectionOnScroll() {
    if (!scrollController.hasClients) return;

    // Check if at the bottom of page -> contact
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 120) {
      if (state.activeSection != 'contact') {
        emit(state.copyWith(activeSection: 'contact'));
      }
      return;
    }

    // Check if at top -> home
    if (scrollController.offset <= 100) {
      if (state.activeSection != 'home') {
        emit(state.copyWith(activeSection: 'home'));
      }
      return;
    }

    const double navBarHeight = 80.0;
    String detectedSection = 'home';
    double minTopDistance = double.infinity;

    // Check each section key position
    final orderedKeys = [
      'home',
      'about',
      'experience',
      'skills',
      'projects',
      'certificates',
      'testimonials',
      'contact',
    ];

    for (final keyName in orderedKeys) {
      final key = sectionKeys[keyName];
      final context = key?.currentContext;
      if (context != null && context.mounted) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null && renderBox.hasSize) {
          final position = renderBox.localToGlobal(Offset.zero);
          final sectionTop = position.dy;
          final sectionBottom = sectionTop + renderBox.size.height;

          // If the section spans across the viewport top reading line (navBarHeight + 60)
          if (sectionTop <= (navBarHeight + 120) && sectionBottom > navBarHeight) {
            detectedSection = keyName;
            break;
          }

          // Fallback: closest section above or near top
          final distance = (sectionTop - navBarHeight).abs();
          if (sectionTop <= navBarHeight + 200 && distance < minTopDistance) {
            minTopDistance = distance;
            detectedSection = keyName;
          }
        }
      }
    }

    if (state.activeSection != detectedSection) {
      emit(state.copyWith(activeSection: detectedSection));
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

    if (key?.currentContext != null && scrollController.hasClients) {
      final renderBox = key!.currentContext!.findRenderObject() as RenderBox?;
      if (renderBox != null && renderBox.hasSize) {
        _isAutoScrolling = true;
        final position = renderBox.localToGlobal(Offset.zero);
        const double navBarOffset = 70.0;
        final targetOffset = (scrollController.offset + position.dy - navBarOffset)
            .clamp(0.0, scrollController.position.maxScrollExtent);

        scrollController
            .animateTo(
          targetOffset,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        )
            .then((_) {
          _isAutoScrolling = false;
          setActiveSection(sectionKey);
        });
      }
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
