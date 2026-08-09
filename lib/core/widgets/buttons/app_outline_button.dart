import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_decorations.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';

class AppOutlineButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? icon;
  final double? width;
  final double height;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final String? semanticLabel;

  const AppOutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.width,
    this.height = 48,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.textStyle,
    this.semanticLabel,
  });

  @override
  State<AppOutlineButton> createState() => _AppOutlineButtonState();
}

class _AppOutlineButtonState extends State<AppOutlineButton> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: true,
      label: widget.semanticLabel ?? widget.text,
      child: FocusableActionDetector(
        mouseCursor: SystemMouseCursors.click,
        onShowHoverHighlight: (val) => setState(() => _isHovered = val),
        onShowFocusHighlight: (val) => setState(() => _isFocused = val),
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) => widget.onPressed(),
          ),
          ButtonActivateIntent: CallbackAction<ButtonActivateIntent>(
            onInvoke: (_) => widget.onPressed(),
          ),
        },
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.width,
            height: widget.height,
            padding: widget.padding,
            decoration: BoxDecoration(
              color: (_isHovered || _isFocused)
                  ? AppColors.glassSurfaceHover
                  : AppColors.glassSurface,
              borderRadius: AppDecorations.radiusMd,
              border: Border.all(
                color: _isFocused
                    ? Colors.white
                    : (_isHovered
                        ? AppColors.primary.withValues(alpha: 0.5)
                        : AppColors.borderSubtle),
                width: _isFocused ? 2 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    widget.text,
                    style: widget.textStyle ??
                        AppTypography.buttonText.copyWith(
                          color: (_isHovered || _isFocused)
                              ? AppColors.primary
                              : AppColors.textPrimary,
                        ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                if (widget.icon != null) ...[
                  const SizedBox(width: 8),
                  widget.icon!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
