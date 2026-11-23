import 'dart:async';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../widgets/portfolio_ui.dart';

class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration duration, delay;
  final double offsetY, offsetX;
  final Curve curve;
  const ScrollReveal({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 720),
    this.delay = Duration.zero,
    this.offsetY = 30,
    this.offsetX = 0,
    this.curve = Curves.easeOutCubic,
  });
  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  final Key visibilityKey = UniqueKey();
  Timer? timer;
  bool revealed = false;
  // Stop visibility callbacks after entry, without replacing the child tree.
  bool settled = false;
  @override
  void initState() {
    super.initState();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted && !settled) {
        setState(() => settled = true);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!PortfolioMotion.enabled(context)) {
      revealed = true;
      settled = true;
      timer?.cancel();
      controller.value = 1;
    }
  }

  void reveal(VisibilityInfo info) {
    if (revealed || info.visibleFraction < 0.02) return;
    revealed = true;
    timer = Timer(widget.delay, () {
      if (mounted) controller.forward();
    });
  }

  @override
  Widget build(BuildContext c) => VisibilityDetector(
    key: visibilityKey,
    onVisibilityChanged: settled ? null : reveal,
    child: AnimatedBuilder(
      animation: controller,
      child: RepaintBoundary(child: widget.child),
      builder: (c, child) {
        final t = widget.curve.transform(controller.value);
        // Translation only. Fading an entire tall section made Flutter render
        // a large offscreen opacity surface during its entrance. Keep the
        // same subtree at completion so interactive state is not recreated.
        return Transform.translate(
          offset: Offset(widget.offsetX * (1 - t), widget.offsetY * (1 - t)),
          child: child,
        );
      },
    ),
  );

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }
}
