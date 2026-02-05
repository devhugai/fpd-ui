/// Responsible for displaying border radius tokens.
/// Provides visual examples of different radii.
///
/// Used by: Router.
/// Depends on: component_page, fpdui_theme.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../theme/fpdui_theme.dart';
import 'component_page.dart';

class RadiusPage extends StatelessWidget {
  const RadiusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return ComponentPage(
      name: 'Radius',
      description: 'Standard border radii used to maintain visual consistency.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RadiusSection(
            label: 'Small',
            value: fpduiTheme.radiusSm,
            description: 'Used for small components like checkboxes and tags.',
          ),
          const Gap(32),
          _RadiusSection(
            label: 'Default',
            value: fpduiTheme.radius,
            description: 'The primary radius used for buttons, inputs, and cards.',
          ),
          const Gap(32),
          _RadiusSection(
            label: 'Large',
            value: fpduiTheme.radiusLg,
            description: 'Used for larger containers like modals and drawers.',
          ),
          const Gap(32),
          _RadiusSection(
            label: 'Extra Large',
            value: fpduiTheme.radiusXl,
            description: 'Used for very large surfaces or special emphasis.',
          ),
             const Gap(32),
          _RadiusSection(
            label: 'Full',
            value: 9999,
            description: 'Used for pills and circular avatars.',
          ),
        ],
      ),
    );
  }
}

class _RadiusSection extends StatelessWidget {
  const _RadiusSection({required this.label, required this.value, required this.description});
  final String label;
  final double value;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: fpduiTheme.primary,
            borderRadius: BorderRadius.circular(value),
          ),
          alignment: Alignment.center,
          child: Text(
            value > 1000 ? 'Full' : value.toStringAsFixed(1),
            style: theme.textTheme.titleMedium?.copyWith(
              color: fpduiTheme.primaryForeground,
              fontWeight: FontWeight.bold,
            ),
          ),
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
                'Value: ${value > 1000 ? "Stadium (9999)" : "$value px"}',
                 style: theme.textTheme.bodySmall?.copyWith(color: fpduiTheme.mutedForeground),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
