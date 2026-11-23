import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/widgets/portfolio_ui.dart';

const _night = Color(0xff101c20);
const _lime = Color(0xffd5f78b);

// Each note restates existing project content. No usage numbers, guarantees,
// personal feelings, or unverified delivery claims are added.
const Map<String, String> projectCardNotes = {
  'hayah':
      'I am engineering Hayah for content discovery, community and accounts. I designed its modular architecture and built authentication, feed and search foundations. It is still in development.',
  'rejeemat':
      'I personally handled the vast majority of Rejeemat’s mobile development. I connected recipes, meal planning, deep links and reminders. The initial app was complete about three months after development began.',
  'rosy-calc':
      'I built and maintained much of the mobile implementation for this published women’s health app, alongside other contributors. My work includes accounts, notifications and offline fallback for articles and the community feed.',
  'qudratuh':
      'I engineered this aptitude-exam preparation app for Saudi students. My mobile work connects learning, assessments and subscriptions, including a split-screen review experience on tablets.',
  'hub-spare-parts':
      'I built and maintained mobile marketplace functionality in a shared codebase. My work connects product discovery, shopping, orders and refund workflows using Flutter, Provider and REST APIs.',
  'doa2k':
      'I built and maintained this medication-reminder app. I connected medication and dose records to Hive persistence and timezone-aware notification scheduling and cancellation.',
  'islami':
      'I built this earlier Flutter project to organize Quran content and resources for daily worship and reflection into a practical mobile experience.',
};

String guideNoteFor(String slug) => projectCardNotes[slug]!;

class GuideNote extends StatelessWidget {
  final String text;
  const GuideNote(this.text, {super.key});
  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _night,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.format_quote_rounded, color: _lime, size: 18),
            SizedBox(width: 8),
            Expanded(child: Eyebrow('Mahmoud / project notes', color: _lime)),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13.5,
            height: 1.6,
          ),
        ),
      ],
    ),
  );
}

/// Touch and keyboard controls work as well as desktop pointer interaction.
/// Motion runs only after an explicit selection, never on an idle timer.
class ProjectWalkthrough extends StatefulWidget {
  final String slug;
  final String challenge;
  final String outcome;
  const ProjectWalkthrough({
    super.key,
    required this.slug,
    required this.challenge,
    required this.outcome,
  });
  @override
  State<ProjectWalkthrough> createState() => _ProjectWalkthroughState();
}

class _ProjectWalkthroughState extends State<ProjectWalkthrough> {
  int selected = 0;
  @override
  Widget build(BuildContext c) {
    final texts = [
      guideNoteFor(widget.slug),
      'The challenge I worked on: ${widget.challenge}',
      'Here is where the project stands: ${widget.outcome}',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            for (final (i, label) in [
              'My work',
              'The challenge',
              'Current status',
            ].indexed)
              ChoiceChip(
                label: Text(label),
                selected: selected == i,
                onSelected: (_) => setState(() => selected = i),
                showCheckmark: false,
                selectedColor: const Color(0xffd5f78b),
              ),
          ],
        ),
        const SizedBox(height: 10),
        AnimatedSwitcher(
          duration: PortfolioMotion.duration(c, 220),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, .06),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          child: GuideNote(texts[selected], key: ValueKey(selected)),
        ),
      ],
    );
  }
}
