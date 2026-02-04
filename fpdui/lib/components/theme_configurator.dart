import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/theme_provider.dart';
import 'button.dart';

class ThemeConfigurator extends ConsumerWidget {
  const ThemeConfigurator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Theme', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: FpduiButton(
                  variant: themeMode == ThemeMode.light ? FpduiButtonVariant.primary : FpduiButtonVariant.outline,
                  onPressed: () {
                    ref.read(themeModeProvider.notifier).state = ThemeMode.light;
                  },
                  icon: const Icon(LucideIcons.sun, size: 16),
                  text: 'Light',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FpduiButton(
                  variant: themeMode == ThemeMode.dark ? FpduiButtonVariant.primary : FpduiButtonVariant.outline,
                  onPressed: () {
                    ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
                  },
                  icon: const Icon(LucideIcons.moon, size: 16),
                  text: 'Dark',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
