import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_decorations.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';

class AppIconButton extends StatefulWidget {
  final String label;
  final String iconGlyph;
  final VoidCallback onPressed;

  const AppIconButton({
    super.key,
    required this.label,
    required this.iconGlyph,
    required this.onPressed,
  });

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.glassSurfaceHover : Colors.transparent,
            borderRadius: AppDecorations.radiusSm,
            border: Border.all(
              color: _isHovered ? AppColors.primary.withValues(alpha: 0.3) : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.iconGlyph,
                style: TextStyle(
                  fontFamily: AppTypography.fontMono,
                  fontSize: 16,
                  color: _isHovered ? AppColors.primary : AppColors.textSubtle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: AppTypography.bodyMedium.copyWith(
                  color: _isHovered ? AppColors.textPrimary : AppColors.textSubtle,
                  fontWeight: _isHovered ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
