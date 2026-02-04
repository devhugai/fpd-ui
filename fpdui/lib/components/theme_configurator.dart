import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/theme_provider.dart';
import 'button.dart';
import 'label.dart';

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

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FpduiLabel('Theme'),
        const Gap(8),
        const Text('Customize the look and feel.', style: TextStyle(fontSize: 12, color: Colors.grey)),
        const Gap(16),
        
        // Mode Toggle
        constTextHeader('Mode'),
        const Gap(8),
        Row(
          children: [
            Expanded(
              child: FpduiButton(
                variant: themeMode == ThemeMode.light ? FpduiButtonVariant.secondary : FpduiButtonVariant.outline,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(LucideIcons.sun, size: 16), Gap(8), Text('Light')],
                ),
                onPressed: () {
                  ref.read(themeModeProvider.notifier).state = ThemeMode.light;
                },
              ),
            ),
            const Gap(8),
            Expanded(
              child: FpduiButton(
                variant: themeMode == ThemeMode.dark ? FpduiButtonVariant.secondary : FpduiButtonVariant.outline,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(LucideIcons.moon, size: 16), Gap(8), Text('Dark')],
                ),
                onPressed: () {
                  ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
                },
              ),
            ),
          ],
        ),

        const Gap(16),
        
        // Color Picker
        constTextHeader('Color'),
        const Gap(8),
        Wrap(
          spacing: 8,
          children: _colors.map((color) {
            final isSelected = currentColor.value == color.value;
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
                      ? Border.all(color: Theme.of(context).colorScheme.onBackground, width: 2) 
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
            return FpduiButton(
              size: FpduiButtonSize.sm,
              variant: isSelected ? FpduiButtonVariant.secondary : FpduiButtonVariant.outline,
              text: radius.toString(),
              onPressed: () {
                 ref.read(themeRadiusProvider.notifier).state = radius;
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
