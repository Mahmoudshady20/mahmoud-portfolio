import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mahmoud_portfolio/core/widgets/portfolio_ui.dart';
import 'package:mahmoud_portfolio/core/constants/app_constants.dart';
import 'package:mahmoud_portfolio/core/animations/scroll_reveal.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});
  @override
  Widget build(BuildContext c) => SectionFrame(
    background: ink,
    child: ScrollReveal(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Eyebrow('06 / Start a conversation', color: Color(0xffc7b3e2)),
          const SizedBox(height: 24),
          const EditorialHeading(
            'Good products start\nwith a conversation.',
            color: paper,
          ),
          const SizedBox(height: 28),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 660),
            child: Text(
              'Discuss a Software Engineer, Mobile Engineer, or Flutter Engineer opportunity — or a mobile application that needs thoughtful architecture and substantial technical ownership.',
              style: prose(size: 18, color: const Color(0xffc4c7be)),
            ),
          ),
          const SizedBox(height: 36),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              const PortfolioButton(
                'Email Mahmoud',
                url: 'mailto:mahmoud4ady@gmail.com',
                primary: true,
                inverse: true,
                icon: Icons.mail_outline_rounded,
              ),
              const PortfolioButton(
                'Connect on LinkedIn',
                url: AppConstants.linkedinUrl,
                inverse: true,
              ),
              const PortfolioButton(
                'Download resume',
                url: AppConstants.cvDownloadUrl,
                inverse: true,
              ),
            ],
          ),
          const SizedBox(height: 36),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SelectableText(
                AppConstants.email,
                style: prose(size: 16, color: paper),
              ),
              IconButton(
                tooltip: 'Copy email address',
                color: paper,
                onPressed: () async {
                  await Clipboard.setData(
                    const ClipboardData(text: AppConstants.email),
                  );
                  if (c.mounted) {
                    ScaffoldMessenger.of(c).showSnackBar(
                      const SnackBar(content: Text('Email address copied.')),
                    );
                  }
                },
                icon: const Icon(Icons.copy_rounded, size: 18),
              ),
              const Eyebrow('Cairo, Egypt', color: Color(0xffc4c7be)),
            ],
          ),
        ],
      ),
    ),
  );
}
