/// Responsible for displaying shadow tokens.
/// Provides visual examples of elevation and depth.
///
/// Used by: Router.
/// Depends on: component_page, fpdui_theme.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'component_page.dart';

class ShadowsPage extends StatelessWidget {
  const ShadowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ComponentPage(
      name: 'Shadows',
      description: 'Elevation levels to imply depth and hierarchy.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ShadowSection(
            label: 'Small / Value 1',
            shadows: const [
              BoxShadow(
                color: Color(0x0F000000),
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
            description: 'Subtle depth, used for cards and buttons.',
          ),
          const Gap(32),
          _ShadowSection(
            label: 'Medium / Value 2',
            shadows: const [
              BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(0, 4),
                blurRadius: 6,
                spreadRadius: -1,
              ),
              BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(0, 2),
                blurRadius: 4,
                spreadRadius: -1,
              ),
            ],
            description: 'Moderate depth, used for dropdowns and popovers.',
          ),
          const Gap(32),
           _ShadowSection(
            label: 'Large / Value 3',
            shadows: const [
              BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(0, 10),
                blurRadius: 15,
                spreadRadius: -3,
              ),
              BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(0, 4),
                blurRadius: 6,
                spreadRadius: -2,
              ),
            ],
            description: 'High depth, used for modals and drawers.',
          ),
        ],
      ),
    );
  }
}

class _ShadowSection extends StatelessWidget {
  const _ShadowSection({
    required this.label, 
    required this.shadows, 
    required this.description,
  });

  final String label;
  final List<BoxShadow> shadows;
  final String description;

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
            borderRadius: BorderRadius.circular(8),
            boxShadow: shadows,
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
                'Shadow Values (Approx)',
                 style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
