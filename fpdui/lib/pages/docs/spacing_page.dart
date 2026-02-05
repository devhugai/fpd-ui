/// Responsible for documenting the spacing system.
/// Explains the 4px grid and layout utilities.
///
/// Used by: Router.
/// Depends on: component_page, fpdui_theme.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../theme/fpdui_theme.dart';
import 'component_page.dart';

class SpacingPage extends StatelessWidget {
  const SpacingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Spacing',
      description: 'The layout spacing system based on a 4px grid.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'The design system uses a 4px base unit. All margins, paddings, and gaps should be multiples of 4.',
            style: TextStyle(fontSize: 16),
          ),
          const Gap(32),
          _SpacingItem(value: 4, token: '0.25rem (px-1)'),
          const Gap(16),
          _SpacingItem(value: 8, token: '0.5rem (px-2)'),
          const Gap(16),
          _SpacingItem(value: 12, token: '0.75rem (px-3)'),
          const Gap(16),
          _SpacingItem(value: 16, token: '1rem (px-4)'),
          const Gap(16),
          _SpacingItem(value: 20, token: '1.25rem (px-5)'),
          const Gap(16),
          _SpacingItem(value: 24, token: '1.5rem (px-6)'),
          const Gap(16),
          _SpacingItem(value: 32, token: '2rem (px-8)'),
          const Gap(16),
          _SpacingItem(value: 40, token: '2.5rem (px-10)'),
          const Gap(16),
          _SpacingItem(value: 48, token: '3rem (px-12)'),
          const Gap(16),
          _SpacingItem(value: 64, token: '4rem (px-16)'),
        ],
      ),
    );
  }
}

class _SpacingItem extends StatelessWidget {
  const _SpacingItem({required this.value, required this.token});
  final double value;
  final String token;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Row(
      children: [
        Container(
          width: value,
          height: 24,
          color: fpduiTheme.primary,
        ),
        const Gap(16),
        Text(
          '${value.toInt()}px',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Gap(8),
        Text(
          token,
          style: TextStyle(color: fpduiTheme.mutedForeground),
        ),
      ],
    );
  }
}
