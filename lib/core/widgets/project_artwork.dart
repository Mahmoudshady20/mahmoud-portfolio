import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'portfolio_ui.dart';
import '../../features/portfolio/domain/entities/project_entity.dart';

class ProjectArtwork extends StatelessWidget {
  final ProjectEntity project;
  final bool large;
  const ProjectArtwork({super.key, required this.project, this.large = false});
  @override
  Widget build(BuildContext c) => Semantics(
    image: true,
    label:
        '${project.title} engineering overview: ${project.visual.join(', ')}',
    child: ExcludeSemantics(
      child: Container(
        color: Color(project.color),
        child: Stack(
          children: [
            const Positioned.fill(child: CustomPaint(painter: _OrbitPainter())),
            Padding(
              padding: EdgeInsets.all(large ? 38 : 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Eyebrow('Engineering overview', color: ink),
                      ),
                      Text(
                        project.number,
                        style: const TextStyle(
                          fontFamily: 'JetBrainsMono',
                          fontSize: 12,
                          color: ink,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Text(project.title, style: display(large ? 52 : 40)),
                  const SizedBox(height: 28),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.visual
                        .map(
                          (s) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: paper.withValues(alpha: .85),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(s, style: prose(size: 12, color: ink)),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _OrbitPainter extends CustomPainter {
  const _OrbitPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ink.withValues(alpha: .12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final center = Offset(size.width * .86, size.height * .35);
    for (var i = 0; i < 3; i++) {
      canvas.drawCircle(center, 55 + i * 55, paint);
    }
    for (var i = 0; i < 6; i++) {
      final a = i * math.pi / 3;
      final p = center + Offset(math.cos(a) * 110, math.sin(a) * 110);
      canvas.drawCircle(p, 4, Paint()..color = ink.withValues(alpha: .16));
    }
    canvas.drawLine(
      Offset(0, size.height * .74),
      Offset(size.width, size.height * .74),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _OrbitPainter oldDelegate) => false;
}
