import 'package:flutter/material.dart';
import '../widgets/portfolio_ui.dart';

/// Makes a region visibly react to the visitor's pointer: layers inside it
/// drift toward the cursor by their own [ParallaxLayer.strength]. Motion is
/// transform-only, driven by pointer events (no ticking controller), and is
/// fully disabled when reduced motion is requested.
class PointerParallax extends StatefulWidget {
  final Widget child;
  const PointerParallax({super.key, required this.child});
  @override
  State<PointerParallax> createState() => _PointerParallaxState();
}

class _PointerParallaxState extends State<PointerParallax> {
  // Normalized pointer position (-1..1 on both axes), smoothed per event.
  Offset position = Offset.zero;

  void _track(PointerEvent event, Size size) {
    if (!size.isFinite || size.width <= 0 || size.height <= 0) return;
    final center = size.center(Offset.zero);
    final target = Offset(
      ((event.localPosition.dx - center.dx) / (size.width / 2)).clamp(
        -1.0,
        1.0,
      ),
      ((event.localPosition.dy - center.dy) / (size.height / 2)).clamp(
        -1.0,
        1.0,
      ),
    );
    final next = Offset.lerp(position, target, 0.35)!;
    if (next != position) setState(() => position = next);
  }

  @override
  Widget build(BuildContext c) {
    if (!PortfolioMotion.enabled(c)) return widget.child;
    return LayoutBuilder(
      builder: (c, constraints) {
        final render = context.findRenderObject();
        final size = Size(
          constraints.maxWidth,
          constraints.hasBoundedHeight
              ? constraints.maxHeight
              : (render is RenderBox && render.hasSize
                    ? render.size.height
                    : 500),
        );
        return MouseRegion(
          onHover: (event) => _track(event, size),
          onExit: (_) => setState(() => position = Offset.zero),
          child: _ParallaxScope(offset: position, child: widget.child),
        );
      },
    );
  }
}

class _ParallaxScope extends InheritedWidget {
  final Offset offset;
  const _ParallaxScope({required this.offset, required super.child});
  static Offset of(BuildContext c) =>
      c.dependOnInheritedWidgetOfExactType<_ParallaxScope>()?.offset ??
      Offset.zero;
  @override
  bool updateShouldNotify(_ParallaxScope old) => old.offset != offset;
}

/// A layer inside a [PointerParallax]; larger [strength] travels further.
class ParallaxLayer extends StatelessWidget {
  final double strength;
  final Widget child;
  const ParallaxLayer({super.key, required this.child, this.strength = 10});
  @override
  Widget build(BuildContext c) {
    final offset = _ParallaxScope.of(c) * strength;
    if (offset == Offset.zero) return child;
    return Transform.translate(offset: offset, child: child);
  }
}
