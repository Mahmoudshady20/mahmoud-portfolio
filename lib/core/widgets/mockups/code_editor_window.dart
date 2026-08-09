import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/theme/app_decorations.dart';
import 'package:mahmoud_portfolio/core/theme/app_gradients.dart';
import 'package:mahmoud_portfolio/core/theme/app_typography.dart';

class CodeEditorWindow extends StatelessWidget {
  final double? width;
  final double? height;

  const CodeEditorWindow({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 320,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppDecorations.radiusLg,
        border: Border.all(color: AppColors.borderSubtle, width: 1),
        boxShadow: AppDecorations.ideWindowShadow,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(
                bottom: BorderSide(color: AppColors.borderFaint, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDot(AppColors.dotRed),
                    const SizedBox(width: 6),
                    _buildDot(AppColors.dotYellow),
                    const SizedBox(width: 6),
                    _buildDot(AppColors.dotGreen),
                  ],
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "home_screen.dart",
                      style: AppTypography.codeSnippet.copyWith(
                        fontSize: 11,
                        color: AppColors.textSubtle,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: AppGradients.codeEditorBackground,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _codeLine([
                  _span("class ", AppColors.syntaxKeyword),
                  _span("HomeScreen ", AppColors.syntaxType),
                  _span("extends ", AppColors.syntaxControl),
                  _span("StatelessWidget ", AppColors.syntaxType),
                  _span("{", AppColors.textPrimary),
                ]),
                const SizedBox(height: 3),
                _codeLine([
                  _span("  @override", AppColors.syntaxKeyword),
                ]),
                const SizedBox(height: 3),
                _codeLine([
                  _span("  Widget ", AppColors.syntaxType),
                  _span("build", AppColors.syntaxFunction),
                  _span("(BuildContext ctx) {", AppColors.textPrimary),
                ]),
                const SizedBox(height: 3),
                _codeLine([
                  _span("    return ", AppColors.syntaxKeyword),
                  _span("Scaffold", AppColors.syntaxType),
                  _span("(", AppColors.syntaxGold),
                ]),
                const SizedBox(height: 3),
                _codeLine([
                  _span("      appBar: ", AppColors.syntaxVariable),
                  _span("AppBar", AppColors.syntaxType),
                  _span("(", AppColors.syntaxBracket),
                ]),
                const SizedBox(height: 3),
                _codeLine([
                  _span("        title: ", AppColors.syntaxVariable),
                  _span("Text", AppColors.syntaxType),
                  _span("('", AppColors.textPrimary),
                  _span("Mahmoud Shady", AppColors.syntaxString),
                  _span("'),", AppColors.textPrimary),
                ]),
                const SizedBox(height: 3),
                _codeLine([
                  _span("      ),", AppColors.syntaxBracket),
                ]),
                const SizedBox(height: 3),
                _codeLine([
                  _span("    );", AppColors.syntaxGold),
                ]),
                const SizedBox(height: 3),
                _codeLine([
                  _span("  }", AppColors.textPrimary),
                ]),
                const SizedBox(height: 3),
                _codeLine([
                  _span("}", AppColors.textPrimary),
                ]),
              ],
            ),
          ),
          Container(
            height: 12,
            decoration: const BoxDecoration(
              gradient: AppGradients.codeEditorFooter,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _codeLine(List<InlineSpan> spans) {
    return Text.rich(
      TextSpan(children: spans),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  InlineSpan _span(String text, Color color) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontFamily: AppTypography.fontMono,
        fontSize: 10.5,
        height: 1.35,
        color: color,
      ),
    );
  }
}
