import 'package:flutter/material.dart';
import 'package:mahmoud_portfolio/core/widgets/portfolio_ui.dart';
import 'package:mahmoud_portfolio/core/constants/app_constants.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});
  @override
  Widget build(BuildContext c) => SectionFrame(
    vertical: 28,
    child: Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 30,
      runSpacing: 18,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConstants.copyrightText,
              style: prose(size: 12, color: ink),
            ),
            Text(
              'Software Engineer · Mobile Application Engineering',
              style: prose(size: 11),
            ),
          ],
        ),
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            PortfolioButton('LinkedIn', url: AppConstants.linkedinUrl),
            PortfolioButton('GitHub', url: AppConstants.githubUrl),
            PortfolioButton('Resume', url: AppConstants.cvDownloadUrl),
          ],
        ),
      ],
    ),
  );
}
