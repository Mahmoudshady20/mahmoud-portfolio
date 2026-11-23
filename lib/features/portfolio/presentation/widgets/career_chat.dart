import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahmoud_portfolio/core/di/injection_container.dart';
import 'package:mahmoud_portfolio/core/theme/app_colors.dart';
import 'package:mahmoud_portfolio/core/widgets/portfolio_ui.dart';
import 'package:mahmoud_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:mahmoud_portfolio/features/portfolio/presentation/cubit/navigation_cubit.dart';

/// One chat exchange: what the visitor asked and what the assistant answered.
class _ChatMessage {
  final String text;
  final bool fromUser;
  final String? sectionKey;
  final String? sectionLabel;
  final String? projectSlug;
  final String? projectLabel;

  const _ChatMessage(
    this.text, {
    this.fromUser = false,
    this.sectionKey,
    this.sectionLabel,
    this.projectSlug,
    this.projectLabel,
  });
}

/// A small, fully client-side career assistant. Every answer is built from
/// the same profile.json facts that power the page; nothing is sent anywhere.
class CareerChat extends StatefulWidget {
  const CareerChat({super.key});

  @override
  State<CareerChat> createState() => _CareerChatState();
}

class _CareerChatState extends State<CareerChat> {
  static const _suggestions = [
    'What does Mahmoud do?',
    'Where does he work now?',
    'Tell me about Hayah',
    'Skills and tools',
    'Education',
    'How can I contact him?',
  ];

  final _messages = <_ChatMessage>[];
  final _input = TextEditingController();
  final _inputFocus = FocusNode();
  final _listController = ScrollController();
  bool _open = false;

  PortfolioRepository get _repo => sl<PortfolioRepository>();

  @override
  void dispose() {
    _input.dispose();
    _inputFocus.dispose();
    _listController.dispose();
    super.dispose();
  }

  void _toggle(bool open) {
    setState(() {
      _open = open;
      if (open && _messages.isEmpty) {
        _messages.add(
          const _ChatMessage(
            'Hi! Ask me anything about Mahmoud’s career: his role, projects, skills, education, or how to reach him. I answer only from what this portfolio already says.',
          ),
        );
      }
    });
    if (open) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _inputFocus.requestFocus();
      });
    }
  }

  void _ask(String raw) {
    final question = raw.trim();
    if (question.isEmpty) return;
    _input.clear();
    setState(() {
      _messages.add(_ChatMessage(question, fromUser: true));
      _messages.add(_answerFor(question));
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_listController.hasClients) return;
      _listController.animateTo(
        _listController.position.maxScrollExtent,
        duration: PortfolioMotion.duration(context, 220),
        curve: Curves.easeOut,
      );
    });
  }

  void _goToSection(String key) {
    context.read<NavigationCubit>().scrollToSection(key);
    _toggle(false);
  }

  void _openProject(String slug) {
    _toggle(false);
    Navigator.pushNamed(context, '/projects/$slug');
  }

  _ChatMessage _answerFor(String question) {
    final q = question.toLowerCase();
    final projects = _repo.getProjects();

    // A named project wins over broader intents.
    for (final p in projects) {
      final name = p.title.toLowerCase();
      if (name.length > 2 && q.contains(name)) {
        return _ChatMessage(
          '${p.title} — ${p.category}. ${p.description} Status: ${p.status}.',
          projectSlug: p.slug,
          projectLabel: 'Open the ${p.title} case study',
          sectionKey: 'projects',
          sectionLabel: 'See all selected work',
        );
      }
    }

    bool any(List<String> words) => words.any(q.contains);

    if (any(['tara'])) {
      final e = _repo.getExperiences().first;
      return _ChatMessage(
        'Mahmoud is currently ${e.role} at ${e.company} (${e.period}). '
        '${e.description.split('\n').first}',
        sectionKey: 'experience',
        sectionLabel: 'Go to experience',
      );
    }
    if (any(['phlera', 'upwork', 'shbbak'])) {
      final matches = _repo
          .getExperiences()
          .where((e) => q.contains(e.company.toLowerCase().split(' ').first))
          .toList();
      if (matches.isNotEmpty) {
        final e = matches.first;
        return _ChatMessage(
          '${e.role} at ${e.company} (${e.period}). '
          '${e.description.split('\n').first}',
          sectionKey: 'experience',
          sectionLabel: 'Go to experience',
        );
      }
    }
    if (any(['current', 'now']) && any(['work', 'job', 'role', 'company'])) {
      final e = _repo.getExperiences().first;
      return _ChatMessage(
        'Right now Mahmoud is ${e.role} at ${e.company} (${e.period}).',
        sectionKey: 'experience',
        sectionLabel: 'Go to experience',
      );
    }
    if (any([
      'experience', 'career', 'work history', 'job', 'jobs', 'worked',
      'companies',
    ])) {
      final roles = _repo
          .getExperiences()
          .map((e) => '${e.role} at ${e.company} (${e.period})')
          .join(' · ');
      return _ChatMessage(
        'His experience so far: $roles. He has been building Flutter applications since 2021.',
        sectionKey: 'experience',
        sectionLabel: 'Go to experience',
      );
    }
    if (any([
      'project', 'projects', 'app', 'apps', 'work', 'portfolio', 'built',
      'build',
    ])) {
      final names = projects.map((p) => p.title).join(', ');
      return _ChatMessage(
        'He has engineered ${projects.length} mobile products featured here: $names. Ask me about any of them by name.',
        sectionKey: 'projects',
        sectionLabel: 'See all selected work',
      );
    }
    if (any([
      'skill', 'skills', 'stack', 'tech', 'technology', 'tools', 'flutter',
      'dart',
    ])) {
      final skills = _repo.getSkills();
      final names = skills.map((s) => s.name).join(', ');
      final main = skills.length > 1 ? skills[1] : skills.first;
      return _ChatMessage(
        'His expertise covers: $names. Day to day that means ${main.technologies.join(', ')}.',
        sectionKey: 'skills',
        sectionLabel: 'Go to expertise',
      );
    }
    if (any([
      'education', 'study', 'studied', 'university', 'degree', 'college',
      'school',
    ])) {
      final edu = _repo
          .getEducation()
          .map((e) => '${e.degree} at ${e.school} (${e.period})')
          .join(' · ');
      return _ChatMessage(
        edu,
        sectionKey: 'education',
        sectionLabel: 'Go to education',
      );
    }
    if (any([
      'contact', 'email', 'mail', 'reach', 'hire', 'linkedin', 'github',
      'connect',
    ])) {
      return const _ChatMessage(
        'You can reach Mahmoud at mahmoud4ady@gmail.com, or through LinkedIn and GitHub — the links are in the contact section.',
        sectionKey: 'contact',
        sectionLabel: 'Go to contact',
      );
    }
    if (any(['where', 'location', 'cairo', 'egypt', 'based', 'live'])) {
      return const _ChatMessage(
        'Mahmoud is based in Cairo, Egypt, working in mobile application engineering.',
        sectionKey: 'about',
        sectionLabel: 'More about him',
      );
    }
    if (any(['resume', 'cv'])) {
      return const _ChatMessage(
        'His full resume is available as a PDF from the experience section — look for “Full experience in my resume”.',
        sectionKey: 'experience',
        sectionLabel: 'Go to experience',
      );
    }
    if (any(['who', 'about', 'mahmoud', 'him', 'introduce'])) {
      return const _ChatMessage(
        'Mahmoud Shady is a Software Engineer specializing in Mobile Application Engineering, based in Cairo. He builds complete iOS and Android applications with Flutter and Dart: architecture, implementation, integrations, testing, and delivery.',
        sectionKey: 'about',
        sectionLabel: 'More about him',
      );
    }
    if (any(['hello', 'hi', 'hey', 'salam', 'salaam', 'ahlan', 'yo '])) {
      return const _ChatMessage(
        'Hello! I can tell you about Mahmoud’s role, experience, projects, skills, education, or how to contact him. What would you like to know?',
      );
    }
    if (any(['thank', 'thanks', 'great', 'cool', 'nice'])) {
      return const _ChatMessage(
        'Happy to help. Anything else about Mahmoud’s work?',
      );
    }
    return const _ChatMessage(
      'I can only share what this portfolio already says: Mahmoud’s role, experience, projects, skills, education, and contact details. Try one of the questions below.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final small = size.width < 720;
    final motion = PortfolioMotion.enabled(context);
    final panelWidth = small ? size.width - 32 : 380.0;
    final panelHeight = (size.height - 140).clamp(320.0, 540.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AnimatedSwitcher(
          duration: PortfolioMotion.duration(context, 240),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween(begin: motion ? 0.96 : 1.0, end: 1.0)
                  .animate(animation),
              alignment: Alignment.bottomRight,
              child: child,
            ),
          ),
          child: !_open
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _ChatPanel(
                    width: panelWidth,
                    height: panelHeight,
                    messages: _messages,
                    listController: _listController,
                    input: _input,
                    inputFocus: _inputFocus,
                    suggestions: _suggestions,
                    onSubmit: _ask,
                    onClose: () => _toggle(false),
                    onSection: _goToSection,
                    onProject: _openProject,
                  ),
                ),
        ),
        Semantics(
          button: true,
          label: _open
              ? 'Close the career assistant'
              : 'Open the career assistant: ask questions about Mahmoud’s career',
          child: FocusableActionDetector(
            shortcuts: const {
              SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
              SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
            },
            actions: {
              ActivateIntent: CallbackAction<ActivateIntent>(
                onInvoke: (_) => _toggle(!_open),
              ),
            },
            child: Material(
              color: AppColors.textPrimary,
              borderRadius: BorderRadius.circular(40),
              elevation: 6,
              shadowColor: Colors.black26,
              child: InkWell(
                borderRadius: BorderRadius.circular(40),
                onTap: () => _toggle(!_open),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: small ? 18 : 20,
                    vertical: 14,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _open
                            ? Icons.close_rounded
                            : Icons.chat_bubble_outline_rounded,
                        color: paper,
                        size: 19,
                      ),
                      if (!small) ...[
                        const SizedBox(width: 10),
                        Text(
                          _open ? 'Close' : 'Ask about my career',
                          style: const TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            color: paper,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ChatPanel extends StatelessWidget {
  final double width;
  final double height;
  final List<_ChatMessage> messages;
  final ScrollController listController;
  final TextEditingController input;
  final FocusNode inputFocus;
  final List<String> suggestions;
  final ValueChanged<String> onSubmit;
  final VoidCallback onClose;
  final ValueChanged<String> onSection;
  final ValueChanged<String> onProject;

  const _ChatPanel({
    required this.width,
    required this.height,
    required this.messages,
    required this.listController,
    required this.input,
    required this.inputFocus,
    required this.suggestions,
    required this.onSubmit,
    required this.onClose,
    required this.onSection,
    required this.onProject,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: line),
          boxShadow: const [
            BoxShadow(
              color: Color(0x24222322),
              blurRadius: 30,
              offset: Offset(0, 14),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Container(
              color: AppColors.textPrimary,
              padding: const EdgeInsets.fromLTRB(18, 14, 8, 14),
              child: Row(
                children: [
                  const Icon(
                    Icons.work_outline_rounded,
                    color: paper,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ask about my career',
                          style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            color: paper,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Answers come from this portfolio only',
                          style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            color: Color(0xB3FFFFFF),
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Semantics(
                    button: true,
                    label: 'Close the career assistant',
                    child: IconButton(
                      onPressed: onClose,
                      icon: const Icon(Icons.close_rounded, color: paper),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Semantics(
                liveRegion: true,
                label: 'Conversation',
                child: ListView.builder(
                  controller: listController,
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
                  itemCount: messages.length,
                  itemBuilder: (context, i) => _Bubble(
                    message: messages[i],
                    onSection: onSection,
                    onProject: onProject,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                itemCount: suggestions.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, i) => Center(
                  child: ActionChip(
                    label: Text(suggestions[i]),
                    labelStyle: const TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 12,
                      color: ink,
                    ),
                    backgroundColor: AppColors.surfaceLight,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () => onSubmit(suggestions[i]),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Semantics(
                      textField: true,
                      label: 'Type a question about Mahmoud’s career',
                      child: TextField(
                        controller: input,
                        focusNode: inputFocus,
                        onSubmitted: onSubmit,
                        textInputAction: TextInputAction.send,
                        style: const TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 14,
                          color: ink,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Ask about his work…',
                          hintStyle: const TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 14,
                            color: muted,
                          ),
                          filled: true,
                          fillColor: AppColors.background,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Semantics(
                    button: true,
                    label: 'Send the question',
                    child: IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: paper,
                      ),
                      onPressed: () => onSubmit(input.text),
                      icon: const Icon(Icons.send_rounded, size: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final _ChatMessage message;
  final ValueChanged<String> onSection;
  final ValueChanged<String> onProject;

  const _Bubble({
    required this.message,
    required this.onSection,
    required this.onProject,
  });

  @override
  Widget build(BuildContext context) {
    final fromUser = message.fromUser;
    return Align(
      alignment: fromUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          decoration: BoxDecoration(
            color: fromUser ? AppColors.primary : AppColors.surfaceLight,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: Radius.circular(fromUser ? 16 : 4),
              bottomRight: Radius.circular(fromUser ? 4 : 16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.text,
                style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 13.5,
                  height: 1.45,
                  color: fromUser ? paper : ink,
                ),
              ),
              if (message.projectSlug != null) ...[
                const SizedBox(height: 8),
                _ChatLink(
                  message.projectLabel!,
                  onTap: () => onProject(message.projectSlug!),
                ),
              ],
              if (message.sectionKey != null) ...[
                const SizedBox(height: 6),
                _ChatLink(
                  message.sectionLabel!,
                  onTap: () => onSection(message.sectionKey!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _ChatLink(this.label, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 13,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
