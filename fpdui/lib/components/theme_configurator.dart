import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/theme_provider.dart';
import '../theme/fpdui_theme.dart';
import 'color_picker.dart';
import 'button.dart';
import 'input.dart';

class ThemeConfigurator extends ConsumerStatefulWidget {
  const ThemeConfigurator({super.key});

  @override
  ConsumerState<ThemeConfigurator> createState() => _ThemeConfiguratorState();
}

class _ThemeConfiguratorState extends ConsumerState<ThemeConfigurator> {
  // Keep track of expansion state if needed, or rely on ExpansionTile defaults.
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mode Selector (Always visible)
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

        // Typography Section
        _ConfigSection(
          title: 'Typography',
          child: _TypographyControls(),
        ),

        // Colors Section
        _ConfigSection(
          title: 'Colors',
          child: _ColorsControls(),
        ),

        // Radius Section
        _ConfigSection(
          title: 'Radius',
          child: _RadiusControls(),
        ),

        // Borders Section
        _ConfigSection(
          title: 'Borders',
          child: _BordersControls(),
        ),

        // Shadows Section
        _ConfigSection(
          title: 'Shadows',
          child: _ShadowsControls(),
        ),
      ],
    );
  }
}

class _ConfigSection extends StatelessWidget {
  const _ConfigSection({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(bottom: 16),
      shape: const Border(), // Remove default borders
      collapsedShape: const Border(),
      initiallyExpanded: false,
      children: [child],
    );
  }
}

class _TypographyControls extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFont = ref.watch(themeFontFamilyProvider);
    final currentScale = ref.watch(themeFontSizeScaleProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Font Family", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
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
        const Gap(16),
        const Text("Base Size Scale", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        Slider(
            value: currentScale,
            min: 0.8,
            max: 1.2,
            divisions: 4,
            label: '${(currentScale * 100).round()}%',
            onChanged: (val) {
                ref.read(themeFontSizeScaleProvider.notifier).state = val;
            },
        ),
      ],
    );
  }
}

class _ColorsControls extends ConsumerWidget {
    @override
    Widget build(BuildContext context, WidgetRef ref) {
        final overrides = ref.watch(themeColorOverridesProvider);
        final theme = Theme.of(context);
        final extension = theme.extension<FpduiTheme>()!;

        // Helper to construct token interactions
        Widget colorTokenRow(String name, Color currentColor, String tokenKey) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                    children: [
                        Container(
                            width: 24, height: 24,
                            decoration: BoxDecoration(
                                color: currentColor,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
                            ),
                        ),
                        const Gap(12),
                        Expanded(child: Text(name, style: const TextStyle(fontSize: 13))),
                        IconButton(
                            icon: const Icon(LucideIcons.pencil, size: 14),
                            onPressed: () {
                                _showColorPickerDialog(context, ref, tokenKey, currentColor);
                            },
                            tooltip: 'Edit $name',
                             constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                             padding: EdgeInsets.zero,
                        )
                    ],
                ),
            );
        }

        return Column(
           children: [
               colorTokenRow('Background', extension.background, 'background'),
               colorTokenRow('Foreground', extension.foreground, 'foreground'),
               colorTokenRow('Primary', extension.primary, 'primary'),
               colorTokenRow('Secondary', extension.secondary, 'secondary'),
               colorTokenRow('Muted', extension.muted, 'muted'),
               colorTokenRow('Accent', extension.accent, 'accent'),
               colorTokenRow('Destructive', extension.destructive, 'destructive'),
               // Add more as essential
           ], 
        );
    }
}

class _RadiusControls extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRadius = ref.watch(themeRadiusProvider);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text("Radius: ${currentRadius.toStringAsFixed(2)}", style: const TextStyle(fontSize: 12)),
            Slider(
                value: currentRadius,
                min: 0.0,
                max: 1.0,
                onChanged: (val) {
                    ref.read(themeRadiusProvider.notifier).state = val;
                },
            ),
        ],
    );
  }
}

class _BordersControls extends ConsumerWidget {
   @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final extension = theme.extension<FpduiTheme>()!;
    
    return Column(
        children: [
             ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                     width: 24, height: 24,
                     decoration: BoxDecoration(color: extension.border, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)),
                ),
                title: const Text('Border Color', style: TextStyle(fontSize: 13)),
                trailing: const Icon(LucideIcons.chevronRight, size: 16),
                onTap: () {
                     _showColorPickerDialog(context, ref, 'border', extension.border);
                },
             ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                     width: 24, height: 24,
                     decoration: BoxDecoration(color: extension.input, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)),
                ),
                title: const Text('Input Border', style: TextStyle(fontSize: 13)),
                trailing: const Icon(LucideIcons.chevronRight, size: 16),
                onTap: () {
                     _showColorPickerDialog(context, ref, 'input', extension.input);
                },
             ),
             ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                     width: 24, height: 24,
                     decoration: BoxDecoration(color: extension.ring, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)),
                ),
                title: const Text('Ring Color', style: TextStyle(fontSize: 13)),
                trailing: const Icon(LucideIcons.chevronRight, size: 16),
                onTap: () {
                     _showColorPickerDialog(context, ref, 'ring', extension.ring);
                },
             ),
        ],
    );
  } 
}

class _ShadowsControls extends ConsumerWidget {
    @override
    Widget build(BuildContext context, WidgetRef ref) {
         final theme = Theme.of(context);
         final extension = theme.extension<FpduiTheme>()!;

         return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                     width: 24, height: 24,
                     decoration: BoxDecoration(color: extension.shadow, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)),
                ),
                title: const Text('Shadow Color', style: TextStyle(fontSize: 13)),
                trailing: const Icon(LucideIcons.chevronRight, size: 16),
                onTap: () {
                     _showColorPickerDialog(context, ref, 'shadow', extension.shadow);
                },
         );
    }
}


// --- Helper Dialog ---

void _showColorPickerDialog(BuildContext context, WidgetRef ref, String tokenKey, Color currentColor) {
    showDialog(
        context: context,
        builder: (ctx) {
             return AlertDialog(
                 title: Text('Edit $tokenKey'),
                 content: SingleChildScrollView(
                     child: SizedBox(
                         width: 320, // ensure width for picker
                         child: FpdColorPicker(
                             colors: const [Colors.red, Colors.blue, Colors.green, Colors.black, Colors.white], // basic presets
                             selectedColor: currentColor,
                             onColorChanged: (newColor) {
                                 // Update Override
                                 final currentOverrides = ref.read(themeColorOverridesProvider);
                                 ref.read(themeColorOverridesProvider.notifier).state = {
                                     ...currentOverrides,
                                     tokenKey: newColor,
                                 };
                             },
                         ),
                     ),
                 ),
                 actions: [
                     TextButton(child: const Text('Done'), onPressed: () => Navigator.of(ctx).pop()),
                 ],
             );
        }
    );
}
