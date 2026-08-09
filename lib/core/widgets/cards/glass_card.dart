import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_decorations.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final String? semanticLabel;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
    this.semanticLabel,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius =
        widget.borderRadius ?? AppDecorations.radiusXl;
    final isInteractive = widget.onTap != null;

    Widget content = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: widget.width,
      height: widget.height,
      padding: widget.padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: widget.backgroundColor ??
            ((_isHovered || _isFocused)
                ? AppColors.glassSurfaceHover
                : AppColors.glassSurface),
        borderRadius: effectiveBorderRadius,
        border: Border.all(
          color: _isFocused
              ? AppColors.primary
              : (widget.borderColor ??
                  ((_isHovered && isInteractive)
                      ? AppColors.primary.withValues(alpha: 0.4)
                      : AppColors.borderSubtle)),
          width: _isFocused ? 2 : 1,
        ),
        boxShadow: (_isHovered && isInteractive)
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      transform: (_isHovered && isInteractive)
          ? Matrix4.translationValues(0.0, -4.0, 0.0)
          : Matrix4.identity(),
      child: widget.child,
    );

    if (isInteractive) {
      content = Semantics(
        button: true,
        enabled: true,
        label: widget.semanticLabel,
        child: FocusableActionDetector(
          mouseCursor: SystemMouseCursors.click,
          onShowHoverHighlight: (val) => setState(() => _isHovered = val),
          onShowFocusHighlight: (val) => setState(() => _isFocused = val),
          actions: {
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (_) => widget.onTap!(),
            ),
            ButtonActivateIntent: CallbackAction<ButtonActivateIntent>(
              onInvoke: (_) => widget.onTap!(),
            ),
          },
          shortcuts: const {
            SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
            SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
          },
          child: GestureDetector(
            onTap: widget.onTap,
            child: content,
          ),
        ),
      );
    }

    return content;
  }
}
