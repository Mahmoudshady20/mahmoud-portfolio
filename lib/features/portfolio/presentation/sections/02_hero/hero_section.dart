import 'dart:math' as math;
import 'package:visibility_detector/visibility_detector.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahmoud_portfolio/core/widgets/portfolio_ui.dart';
import 'package:mahmoud_portfolio/core/constants/app_constants.dart';
import 'package:mahmoud_portfolio/core/animations/scroll_reveal.dart';

import '../../cubit/navigation_cubit.dart';

const _night = Color(0xff101c20);
const _lime = Color(0xffd5f78b);

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});
  @override
  Widget build(BuildContext c) => Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_night, Color(0xff193b3b)],
      ),
    ),
    child: SectionFrame(
      background: Colors.transparent,
      vertical: MediaQuery.sizeOf(c).width < 720 ? 42 : 72,
      child: LayoutBuilder(
        builder: (c, b) {
          final wide = b.maxWidth > 850;
          final intro = ScrollReveal(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff50706a)),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Eyebrow(
                    'Flutter & Dart / iOS + Android',
                    color: _lime,
                  ),
                ),
                const SizedBox(height: 30),
                Semantics(
                  header: true,
                  headingLevel: 1,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Complete apps.\n'),
                        const TextSpan(
                          text: 'Considered\n',
                          style: TextStyle(color: _lime),
                        ),
                        const TextSpan(text: 'engineering.'),
                      ],
                    ),
                    style: display(
                      wide ? 68 : (b.maxWidth > 540 ? 64 : 43),
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Text(
                    'I’m Mahmoud Shady. I turn business requirements into complete mobile applications, from architecture to delivery and everything that follows.',
                    style: prose(size: 17, color: const Color(0xffbdcecc)),
                  ),
                ),
                const SizedBox(height: 30),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    PortfolioButton(
                      'Explore selected work',
                      primary: true,
                      inverse: true,
                      icon: Icons.south_east_rounded,
                      onPressed: () =>
                          c.read<NavigationCubit>().scrollToSection(
                            'projects',
                            animated: PortfolioMotion.enabled(c),
                            topInset: MediaQuery.textScalerOf(c).scale(17) > 27
                                ? 108
                                : 84,
                          ),
                    ),
                    const PortfolioButton(
                      'Download resume',
                      url: AppConstants.cvDownloadUrl,
                      inverse: true,
                    ),
                  ],
                ),
                const SizedBox(height: 34),
                const Eyebrow(
                  'Cairo, Egypt / Architecture → Delivery',
                  color: Color(0xffa7bfba),
                ),
              ],
            ),
          );
          final visual = ScrollReveal(
            delay: const Duration(milliseconds: 180),
            child: MediaQuery.withNoTextScaling(
              child: const HeroAmbient(child: _EngineeringComposition()),
            ),
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (wide)
                Row(
                  children: [
                    Expanded(flex: 6, child: intro),
                    const SizedBox(width: 44),
                    Expanded(flex: 4, child: visual),
                  ],
                )
              else ...[
                intro,
                const SizedBox(height: 44),
                visual,
              ],
              const SizedBox(height: 52),
              Container(
                padding: const EdgeInsets.only(top: 22),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0xff3a5552))),
                ),
                child: const Wrap(
                  spacing: 30,
                  runSpacing: 14,
                  children: [
                    Eyebrow('Clean Architecture', color: Color(0xffbdcecc)),
                    Eyebrow('BLoC / Cubit', color: Color(0xffbdcecc)),
                    Eyebrow('REST APIs & Firebase', color: Color(0xffbdcecc)),
                    Eyebrow('Responsive & RTL', color: Color(0xffbdcecc)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

class _EngineeringComposition extends StatelessWidget {
  const _EngineeringComposition();
  @override
  Widget build(BuildContext c) => LayoutBuilder(
    builder: (c, b) {
      // Decorative concept, not a screenshot or a claim about a released app.
      final scale = math.min(1.0, b.maxWidth / 390);
      return Semantics(
        image: true,
        label:
            'Concept illustration of a mobile application and its architecture, not an app screenshot',
        child: ExcludeSemantics(
          child: SizedBox(
            height: 500 * scale,
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: 390,
                height: 500,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(painter: _CircuitPainter()),
                    ),
                    Positioned(
                      top: 22,
                      left: 70,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: PortfolioMotion.duration(c, 1300),
                        curve: Curves.easeOutCubic,
                        builder: (c, t, child) => Transform.translate(
                          offset: Offset(0, 28 * (1 - t)),
                          child: Transform.rotate(
                            angle: -.055 * t,
                            child: child,
                          ),
                        ),
                        child: Container(
                          width: 242,
                          height: 441,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xff253c3c),
                            borderRadius: BorderRadius.circular(38),
                            border: Border.all(
                              color: const Color(0xff608079),
                              width: 1.5,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x60000000),
                                blurRadius: 45,
                                offset: Offset(0, 25),
                              ),
                            ],
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xfff4f7ef),
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    width: 58,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: _night,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 29),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.apps_rounded, color: _night),
                                    Icon(
                                      Icons.north_east_rounded,
                                      color: _night,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 22),
                                Text(
                                  'Thoughtfully\nbuilt.',
                                  style: display(31, color: _night),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  height: 83,
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: _lime,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.layers_outlined,
                                        size: 32,
                                        color: _night,
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          'One product.\nEvery layer.',
                                          style: TextStyle(
                                            color: _night,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 14),
                                for (final w in [150.0, 110.0, 135.0])
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 9),
                                    child: Container(
                                      width: w,
                                      height: 7,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffd8e2d9),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                const Spacer(),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(Icons.home_rounded, color: _night),
                                    Icon(
                                      Icons.grid_view_rounded,
                                      color: Color(0xff81948b),
                                    ),
                                    Icon(
                                      Icons.person_outline_rounded,
                                      color: Color(0xff81948b),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: _label(
                        Icons.account_tree_outlined,
                        'Clean architecture',
                        'A foundation for change',
                      ),
                    ),
                    Positioned(
                      bottom: 55,
                      right: 0,
                      child: _label(
                        Icons.check_circle_outline_rounded,
                        'Built for real life',
                        'From interface to integration',
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
                      left: 70,
                      child: Eyebrow(
                        'Mobile engineering / concept',
                        color: Color(0xffa7bfba),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
  Widget _label(IconData icon, String title, String sub) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xff254641),
      border: Border.all(color: const Color(0xff51736b)),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          color: Color(0x25000000),
          blurRadius: 24,
          offset: Offset(0, 12),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: _lime, size: 25),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              sub,
              style: const TextStyle(color: Color(0xffbdcecc), fontSize: 10),
            ),
          ],
        ),
      ],
    ),
  );
}

class _CircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = const Color(0xff365b52)
      ..style = PaintingStyle.stroke;
    for (final r in [130.0, 180.0, 230.0]) {
      canvas.drawCircle(Offset(size.width / 2, size.height / 2), r, p);
    }
    canvas.drawCircle(const Offset(340, 80), 5, Paint()..color = _lime);
    canvas.drawCircle(const Offset(25, 320), 3, Paint()..color = _lime);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// One bounded repaint island, paused offscreen and when motion is disabled.
class HeroAmbient extends StatefulWidget {
  final Widget child;
  const HeroAmbient({super.key, required this.child});
  @override
  State<HeroAmbient> createState() => _HeroAmbientState();
}

class _HeroAmbientState extends State<HeroAmbient>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 7),
  );
  final visibilityKey = UniqueKey();
  bool visible = true;
  bool foreground = true;
  bool disposed = false;
  void syncMotion() {
    if (disposed || !mounted) return;
    if (visible && foreground && PortfolioMotion.enabled(context)) {
      if (!controller.isAnimating) controller.repeat(reverse: true);
    } else {
      controller.stop();
      if (!PortfolioMotion.enabled(context)) controller.value = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    syncMotion();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    foreground = state == AppLifecycleState.resumed;
    syncMotion();
  }

  @override
  Widget build(BuildContext context) => VisibilityDetector(
    key: visibilityKey,
    onVisibilityChanged: (info) {
      visible = info.visibleFraction > .02;
      syncMotion();
    },
    child: RepaintBoundary(
      child: AnimatedBuilder(
        animation: controller,
        child: RepaintBoundary(child: widget.child),
        builder: (context, child) {
          final t = Curves.easeInOutSine.transform(controller.value);
          return Transform.translate(
            offset: Offset(0, -7 * t),
            child: Transform.rotate(angle: .008 * t, child: child),
          );
        },
      ),
    ),
  );
  @override
  void dispose() {
    disposed = true;
    WidgetsBinding.instance.removeObserver(this);
    controller.dispose();
    super.dispose();
  }
}
