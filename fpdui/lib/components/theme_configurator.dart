// Responsible for providing UI to customize app theme.
// Provides ThemeConfigurator widget.
//
// Used by: Kitchen Sink, Settings page.
// Depends on: theme_provider, fpdui_theme.
// Assumes: Access to global Riverpod providers.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/theme_provider.dart';

class ThemeConfigurator extends ConsumerWidget {
  const ThemeConfigurator({super.key});

  static const List<Color> _colors = [
    Colors.black, // Zinc
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
  ];

  static const List<double> _radii = [0.0, 0.3, 0.5, 0.75, 1.0];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final currentRadius = ref.watch(themeRadiusProvider);
    final currentColor = ref.watch(themePrimaryColorProvider);
    final currentFont = ref.watch(themeFontFamilyProvider);
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Theme', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const Gap(8),
        Text('Customize the look and feel.', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
        const Gap(16),
        
        // Mode Toggle
        constTextHeader('Mode'),
        const Gap(8),
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(
                value: ThemeMode.light,
                label: Text('Light'),
                icon: Icon(LucideIcons.sun, size: 16),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text('Dark'),
                icon: Icon(LucideIcons.moon, size: 16),
              ),
            ],
            selected: {themeMode},
            onSelectionChanged: (Set<ThemeMode> newSelection) {
              ref.read(themeModeProvider.notifier).state = newSelection.first;
            },
            showSelectedIcon: false,
          ),
        ),

        const Gap(16),
        
        // Color Picker
        constTextHeader('Color'),
        const Gap(8),
        Wrap(
          spacing: 8,
          children: _colors.map((color) {
            final isSelected = currentColor == color;
            return GestureDetector(
              onTap: () {
                 ref.read(themePrimaryColorProvider.notifier).state = color;
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: isSelected 
                      ? Border.all(color: theme.colorScheme.onSurface, width: 2) 
                      : null,
                ),
                child: isSelected ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
              ),
            );
          }).toList(),
        ),

        const Gap(16),

        // Radius Picker
        constTextHeader('Radius'),
        const Gap(8),
        Wrap(
          spacing: 8,
          children: _radii.map((radius) {
            final isSelected = currentRadius == radius;
            return ChoiceChip(
              label: Text(radius.toString()),
              selected: isSelected,
              onSelected: (bool selected) {
                if (selected) {
                  ref.read(themeRadiusProvider.notifier).state = radius;
                }
              },
            );
          }).toList(),
        ),

        const Gap(16),

        // Typography Picker
        constTextHeader('Typography'),
        const Gap(8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['Inter', 'Roboto', 'Lato', 'Open Sans', 'Poppins'].map((font) {
            final isSelected = currentFont == font;
            return ChoiceChip(
              label: Text(font),
              selected: isSelected,
              onSelected: (bool selected) {
                if (selected) {
                  ref.read(themeFontFamilyProvider.notifier).state = font;
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
  
  Widget constTextHeader(String text) {
    return Text(
      text, 
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
    );
  }
}
