import 'package:flutter/material.dart';
import '../utils/url_helper.dart';
import '../theme/app_typography.dart';
import '../theme/app_colors.dart';

const ink = AppColors.textPrimary,
    muted = AppColors.textSecondary,
    paper = AppColors.background,
    accent = AppColors.primary,
    line = AppColors.borderSubtle;

abstract class PortfolioMotion {
  static bool enabled(BuildContext c) =>
      !(MediaQuery.maybeOf(c)?.disableAnimations ?? false) &&
      !(MediaQuery.maybeOf(c)?.accessibleNavigation ?? false);
  static Duration duration(BuildContext c, [int ms = 240]) =>
      enabled(c) ? Duration(milliseconds: ms) : Duration.zero;
}

TextStyle display(double size, {Color color = ink}) =>
    AppTypography.editorialDisplay(size, color: color);
TextStyle prose({double size = 16, Color color = muted}) =>
    AppTypography.body(size, color: color);

class SectionFrame extends StatelessWidget {
  final Widget child;
  final Color? background;
  final double? vertical;
  const SectionFrame({
    super.key,
    required this.child,
    this.background,
    this.vertical,
  });
  @override
  Widget build(BuildContext c) {
    final small = MediaQuery.sizeOf(c).width < 720;
    return ColoredBox(
      color: background ?? paper,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: small ? 24 : 48,
              vertical: vertical ?? (small ? 64 : 100),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class Eyebrow extends StatelessWidget {
  final String text;
  final Color color;
  const Eyebrow(this.text, {super.key, this.color = muted});
  @override
  Widget build(BuildContext c) => Text(
    text.toUpperCase(),
    style: TextStyle(
      fontFamily: 'JetBrainsMono',
      fontSize: 11.5,
      fontWeight: FontWeight.w500,
      height: 1.6,
      letterSpacing: 1.5,
      color: color,
    ),
  );
}

class EditorialHeading extends StatelessWidget {
  final String text;
  final Color color;
  final int level;
  const EditorialHeading(
    this.text, {
    super.key,
    this.color = ink,
    this.level = 2,
  });
  @override
  Widget build(BuildContext c) => Semantics(
    header: true,
    headingLevel: level,
    child: Text(
      text,
      style: display(MediaQuery.sizeOf(c).width < 720 ? 34 : 48, color: color),
    ),
  );
}

class PortfolioButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final String? url;
  final bool primary, inverse;
  final IconData icon;
  const PortfolioButton(
    this.label, {
    super.key,
    this.onPressed,
    this.url,
    this.primary = false,
    this.inverse = false,
    this.icon = Icons.arrow_outward_rounded,
  });
  @override
  Widget build(BuildContext c) {
    final foreground = inverse ? paper : ink;
    return FilledButton.icon(
      onPressed:
          onPressed ??
          (url == null
              ? null
              : () async {
                  final ok = await UrlHelper.openUrl(url!);
                  if (!ok && c.mounted) {
                    ScaffoldMessenger.of(c).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Unable to open this link. Please try again.',
                        ),
                      ),
                    );
                  }
                }),
      style: FilledButton.styleFrom(
        backgroundColor: primary ? (inverse ? paper : ink) : Colors.transparent,
        foregroundColor: primary ? (inverse ? ink : paper) : foreground,
        minimumSize: const Size(48, 52),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 17),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: primary
              ? BorderSide.none
              : BorderSide(color: inverse ? const Color(0xff777970) : line),
        ),
        textStyle: const TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      icon: Icon(icon, size: 17),
      label: Text(label),
    );
  }
}

class HoverSurface extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final String? semanticLabel;
  const HoverSurface({
    super.key,
    required this.child,
    this.onTap,
    this.semanticLabel,
  });
  @override
  State<HoverSurface> createState() => _HoverSurfaceState();
}

class _HoverSurfaceState extends State<HoverSurface> {
  bool hover = false;
  @override
  Widget build(BuildContext c) => MouseRegion(
    onEnter: (_) => setState(() => hover = true),
    onExit: (_) => setState(() => hover = false),
    child: AnimatedContainer(
      duration: PortfolioMotion.duration(c),
      transform: Matrix4.translationValues(
        0,
        hover && PortfolioMotion.enabled(c) ? -4 : 0,
        0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: hover ? accent : line),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          if (hover)
            const BoxShadow(
              color: Color(0x12222322),
              blurRadius: 24,
              offset: Offset(0, 10),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(12),
          child: Semantics(label: widget.semanticLabel, child: widget.child),
        ),
      ),
    ),
  );
}

class TechnologyLine extends StatelessWidget {
  final List<String> items;
  const TechnologyLine(this.items, {super.key});
  @override
  Widget build(BuildContext c) => Wrap(
    spacing: 10,
    runSpacing: 8,
    children: items
        .map(
          (x) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: line),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(x, style: prose(size: 11.5, color: ink)),
          ),
        )
        .toList(),
  );
}

class StatusLabel extends StatelessWidget {
  final String text;
  const StatusLabel(this.text, {super.key});
  @override
  Widget build(BuildContext c) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 6,
        height: 6,
        decoration: const BoxDecoration(color: accent, shape: BoxShape.circle),
      ),
      const SizedBox(width: 8),
      Flexible(
        child: Text(text, style: prose(size: 12, color: ink)),
      ),
    ],
  );
}
