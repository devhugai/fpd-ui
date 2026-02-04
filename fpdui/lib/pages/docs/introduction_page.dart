import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../theme/fpdui_theme.dart';
import 'component_page.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentPage(
      name: 'Introduction',
      description: 'Re-usable components built using Riverpod and Tailwind CSS.',
      child: Container(
        color: theme.colorScheme.background,
        child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This is a port of shadcn/ui to Flutter.',
            style: TextStyle(fontSize: 16),
          ),
          Gap(16),
          Text(
            'It is NOT a component library. It is a collection of re-usable components that you can copy and paste into your apps.',
            style: TextStyle(fontSize: 14),
          ),
        ],
        ),
      ),
    );
  }
}
