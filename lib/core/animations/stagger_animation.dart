import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/animations/scroll_reveal.dart';

/// Wraps a list of children in [ScrollReveal] widgets with incremental
/// stagger delays. Useful for grids and lists where items should
/// cascade in sequence.
class StaggeredList extends StatelessWidget {
  final List<Widget> children;
  final Duration baseDelay;
  final Duration staggerInterval;
  final Duration duration;
  final double offsetY;
  final double offsetX;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Axis direction;

  const StaggeredList({
    super.key,
    required this.children,
    this.baseDelay = Duration.zero,
    this.staggerInterval = const Duration(milliseconds: 70),
    this.duration = const Duration(milliseconds: 400),
    this.offsetY = 20.0,
    this.offsetX = 0.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.direction = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    final wrappedChildren = List.generate(children.length, (index) {
      return ScrollReveal(
        delay: baseDelay + staggerInterval * index,
        duration: duration,
        offsetY: offsetY,
        offsetX: offsetX,
        child: children[index],
      );
    });

    if (direction == Axis.horizontal) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: wrappedChildren,
      );
    }

    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: wrappedChildren,
    );
  }
}

/// A helper that generates the stagger delay for a given index.
/// Useful in GridView.builder and ListView.builder where you can't
/// use [StaggeredList] directly.
Duration staggerDelay(int index, {Duration interval = const Duration(milliseconds: 70)}) {
  return interval * index;
}
