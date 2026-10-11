import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/widgets/portfolio_ui.dart';
import 'package:mahmoud_portfolio/core/animations/scroll_reveal.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});
  @override
  Widget build(BuildContext c) => SectionFrame(
    background: const Color(0xffebe9e2),
    child: ScrollReveal(
      child: LayoutBuilder(
        builder: (c, b) {
          final intro = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Eyebrow('02 / The way I engineer'),
              const SizedBox(height: 18),
              const EditorialHeading('Ownership across\nthe mobile lifecycle.'),
              const SizedBox(height: 28),
              Text(
                'I’m a Software Engineer specializing in Mobile Application Engineering. Across my projects, I’ve personally handled the vast majority of mobile development — architecture, implementation, integrations, debugging, and delivery.',
                style: prose(size: 17, color: ink),
              ),
              const SizedBox(height: 18),
              Text(
                'I build applications from scratch and maintain published products. I can independently carry substantial mobile development while collaborating with designers, backend engineers, and other contributors.',
                style: prose(size: 16),
              ),
            ],
          );
          final approach = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final (n, title, text) in [
                (
                  '01',
                  'Structure for change',
                  'Design clear responsibilities for presentation, state, data, and integrations. Keep the codebase practical to maintain as the product grows.',
                ),
                (
                  '02',
                  'Connect the whole experience',
                  'Resolve the behavior between features: sessions, unreliable connectivity, purchases, shared links, and navigation.',
                ),
                (
                  '03',
                  'Deliver, then keep improving',
                  'Test critical behavior, investigate defects across the application, and maintain the product beyond its first delivery.',
                ),
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Eyebrow(n, color: accent),
                      const SizedBox(height: 10),
                      Text(title, style: display(24)),
                      const SizedBox(height: 12),
                      Text(text, style: prose(size: 15)),
                    ],
                  ),
                ),
            ],
          );
          return b.maxWidth > 850
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: intro),
                    const SizedBox(width: 100),
                    Expanded(flex: 4, child: approach),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [intro, const SizedBox(height: 44), approach],
                );
        },
      ),
    ),
  );
}
