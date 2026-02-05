/// Responsible for documenting standard sizes.
/// Covers component dimensions and icon sizes.
///
/// Used by: Router.
/// Depends on: component_page, fpdui_theme.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../theme/fpdui_theme.dart';
import 'component_page.dart';

class SizesPage extends StatelessWidget {
  const SizesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Sizes',
      description: 'Standard dimensions for components and icons.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Component Heights', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Gap(16),
          _SizeItem(label: 'Small (sm)', value: 36, tailwind: 'h-9'),
          const Gap(16),
          _SizeItem(label: 'Default', value: 40, tailwind: 'h-10'),
          const Gap(16),
          _SizeItem(label: 'Large (lg)', value: 44, tailwind: 'h-11'),
          const Gap(16),
          _SizeItem(label: 'Icon Button', value: 40, width: 40, tailwind: 'h-10 w-10'),
          
          const Gap(48),
          const Text('Icon Sizes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Gap(16),
          _IconSizeItem(label: 'Small', size: 16),
          const Gap(16),
          _IconSizeItem(label: 'Default', size: 24),
          const Gap(16),
          _IconSizeItem(label: 'Large', size: 32),
        ],
      ),
    );
  }
}

class _SizeItem extends StatelessWidget {
  const _SizeItem({required this.label, required this.value, this.width, required this.tailwind});
  final String label;
  final double value;
  final double? width;
  final String tailwind;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Row(
      children: [
        Container(
          height: value,
          width: width ?? 120,
          decoration: BoxDecoration(
            color: fpduiTheme.muted,
            border: Border.all(color: fpduiTheme.border),
            borderRadius: BorderRadius.circular(fpduiTheme.radius),
          ),
          alignment: Alignment.center,
          child: Text(
            '${value.toInt()}px',
            style: TextStyle(color: fpduiTheme.mutedForeground, fontSize: 12),
          ),
        ),
        const Gap(24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(tailwind, style: TextStyle(color: fpduiTheme.mutedForeground)),
          ],
        ),
      ],
    );
  }
}

class _IconSizeItem extends StatelessWidget {
  const _IconSizeItem({required this.label, required this.size});
  final String label;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        Icon(Icons.widgets, size: size),
        const Gap(24),
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('${size.toInt()}px', style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.6))),
          ],
        ),
      ],
    );
  }
}
