/// Responsible for displaying the color palette of the design system.
/// Provides visual examples of semantic colors.
///
/// Used by: Router.
/// Depends on: component_page, fpdui_theme.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../theme/fpdui_theme.dart';
import 'component_page.dart';

class ColorsPage extends StatelessWidget {
  const ColorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return ComponentPage(
      name: 'Colors',
      description: 'The semantic color palette used throughout the design system.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ColorSection(
            title: 'Base',
            colors: [
              _ColorItem(name: 'Background', color: fpduiTheme.background, onColor: fpduiTheme.foreground),
              _ColorItem(name: 'Foreground', color: fpduiTheme.foreground, onColor: fpduiTheme.background),
            ],
          ),
          const Gap(32),
          _ColorSection(
            title: 'Primary',
            colors: [
              _ColorItem(name: 'Primary', color: fpduiTheme.primary, onColor: fpduiTheme.primaryForeground),
              _ColorItem(name: 'Primary Foreground', color: fpduiTheme.primaryForeground, onColor: fpduiTheme.primary),
            ],
          ),
          const Gap(32),
          _ColorSection(
            title: 'Secondary',
            colors: [
              _ColorItem(name: 'Secondary', color: fpduiTheme.secondary, onColor: fpduiTheme.secondaryForeground),
              _ColorItem(name: 'Secondary Foreground', color: fpduiTheme.secondaryForeground, onColor: fpduiTheme.secondary),
            ],
          ),
          const Gap(32),
          _ColorSection(
            title: 'Accent',
            colors: [
              _ColorItem(name: 'Accent', color: fpduiTheme.accent, onColor: fpduiTheme.accentForeground),
              _ColorItem(name: 'Accent Foreground', color: fpduiTheme.accentForeground, onColor: fpduiTheme.accent),
            ],
          ),
          const Gap(32),
          _ColorSection(
            title: 'Destructive',
            colors: [
              _ColorItem(name: 'Destructive', color: fpduiTheme.destructive, onColor: fpduiTheme.destructiveForeground),
              _ColorItem(name: 'Destructive Foreground', color: fpduiTheme.destructiveForeground, onColor: fpduiTheme.destructive),
            ],
          ),
          const Gap(32),
          _ColorSection(
            title: 'Muted',
            colors: [
              _ColorItem(name: 'Muted', color: fpduiTheme.muted, onColor: fpduiTheme.mutedForeground),
              _ColorItem(name: 'Muted Foreground', color: fpduiTheme.mutedForeground, onColor: fpduiTheme.background),
            ],
          ),
          const Gap(32),
          _ColorSection(
            title: 'Feedback',
            colors: [
              _ColorItem(name: 'Success', color: fpduiTheme.success, onColor: fpduiTheme.successForeground),
              _ColorItem(name: 'Warning', color: fpduiTheme.warning, onColor: fpduiTheme.warningForeground),
              _ColorItem(name: 'Info', color: fpduiTheme.info, onColor: fpduiTheme.infoForeground),
            ],
          ),
          const Gap(32),
          _ColorSection(
            title: 'UI',
            colors: [
              _ColorItem(name: 'Border', color: fpduiTheme.border, onColor: fpduiTheme.foreground),
              _ColorItem(name: 'Input', color: fpduiTheme.input, onColor: fpduiTheme.foreground),
              _ColorItem(name: 'Ring', color: fpduiTheme.ring, onColor: fpduiTheme.background),
            ],
          ),
        ],
      ),
    );
  }
}

class _ColorSection extends StatelessWidget {
  const _ColorSection({required this.title, required this.colors});
  final String title;
  final List<_ColorItem> colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        const Gap(16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: colors,
        ),
      ],
    );
  }
}

class _ColorItem extends StatelessWidget {
  const _ColorItem({required this.name, required this.color, required this.onColor});
  final String name;
  final Color color;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8), // Standard radius visually
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: onColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(4),
          Text(
            '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: onColor.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
