import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Animates a numeric value from 0 to the target when scrolled into view.
///
/// Parses strings like "12+", "98%", "3.5K" — extracts the numeric portion,
/// animates it, and appends the suffix.
class AnimatedCounter extends StatefulWidget {
  final String value;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Duration duration;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.style,
    this.textAlign,
    this.duration = const Duration(milliseconds: 800),
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _hasAnimated = false;
  late final Key _visibilityKey;

  late final int _numericValue;
  late final String _prefix;
  late final String _suffix;

  @override
  void initState() {
    super.initState();
    _visibilityKey = UniqueKey();

    // Parse the value string to extract numeric and non-numeric parts
    _parseValue();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
  }

  void _parseValue() {
    final raw = widget.value;

    // Find the numeric part using regex
    final match = RegExp(r'([^\d]*)(\d+)(.*)').firstMatch(raw);
    if (match != null) {
      _prefix = match.group(1) ?? '';
      _numericValue = int.tryParse(match.group(2) ?? '0') ?? 0;
      _suffix = match.group(3) ?? '';
    } else {
      _prefix = '';
      _numericValue = 0;
      _suffix = raw;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_hasAnimated) return;
    if (info.visibleFraction > 0.15) {
      _hasAnimated = true;
      if (mounted) {
        _controller.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final currentValue =
              (_numericValue * _animation.value).round();
          return Text(
            '$_prefix$currentValue$_suffix',
            style: widget.style,
            textAlign: widget.textAlign,
          );
        },
      ),
    );
  }
}
