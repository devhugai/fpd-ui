/// Responsible for displaying border tokens.
/// Provides visual examples of different borders.
///
/// Used by: Router.
/// Depends on: component_page, fpdui_theme.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../theme/fpdui_theme.dart';
import 'component_page.dart';

class BordersPage extends StatelessWidget {
  const BordersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return ComponentPage(
      name: 'Borders',
      description: 'Standard border styles ensuring clarity and structure.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BorderSection(
            label: 'Default Border',
            border: Border.all(color: fpduiTheme.border, width: 1),
            description: 'The standard border used for cards, inputs, and dividers.',
            colorName: 'border',
          ),
          const Gap(32),
          _BorderSection(
            label: 'Active / Focus Ring',
            border: Border.all(color: fpduiTheme.ring, width: 2),
            description: 'Used for active states or focus indicators.',
            colorName: 'ring',
          ),
          const Gap(32),
           _BorderSection(
            label: 'Input Border',
            border: Border.all(color: fpduiTheme.input, width: 1),
            description: 'Specifically used for input fields.',
            colorName: 'input',
          ),
        ],
      ),
    );
  }
}

class _BorderSection extends StatelessWidget {
  const _BorderSection({
    required this.label, 
    required this.border, 
    required this.description,
    required this.colorName,
  });

  final String label;
  final BoxBorder border;
  final String description;
  final String colorName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: border,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
        ),
        const Gap(24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const Gap(8),
              Text(description, style: theme.textTheme.bodyMedium),
              const Gap(8),
              Text(
                'Color Token: $colorName',
                 style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
