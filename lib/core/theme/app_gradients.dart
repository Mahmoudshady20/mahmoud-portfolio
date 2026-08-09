import 'package:flutter/material.dart';

abstract class AppGradients {
  static const LinearGradient primaryButton = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4F8CFF), // rgb(79, 140, 255)
      Color(0xFF7B6EF6), // rgb(123, 110, 246)
    ],
  );

  static const LinearGradient heroHighlightBluePurple = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4F8CFF),
      Color(0xFF8B5CF6),
    ],
  );

  static const LinearGradient heroHighlightCyanBlue = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF22D3EE),
      Color(0xFF4F8CFF),
    ],
  );

  static const LinearGradient sectionHighlight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4F8CFF),
      Color(0xFF8B5CF6),
    ],
  );

  static const LinearGradient cyanBlueHighlight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF22D3EE),
      Color(0xFF4F8CFF),
    ],
  );

  static const LinearGradient impactBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x0A4F8CFF), // rgba(79, 140, 255, 0.04)
      Color(0x088B5CF6), // rgba(139, 92, 246, 0.03)
    ],
  );

  static const LinearGradient codeEditorBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0D1117),
      Color(0xFF161B22),
    ],
  );

  static const LinearGradient codeEditorFooter = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1C2030),
      Color(0xFF141824),
    ],
  );

  static const LinearGradient skillProgress = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF4F8CFF),
      Color(0xFF8B5CF6),
    ],
  );
}
