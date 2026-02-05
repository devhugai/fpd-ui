/// Responsible for displaying documentation for Toggle component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: toggle.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../components/toggle.dart';
import 'component_page.dart';

class TogglePage extends StatefulWidget {
  const TogglePage({super.key});

  @override
  State<TogglePage> createState() => _TogglePageState();
}

class _TogglePageState extends State<TogglePage> {
  bool isBold = false;
  bool isItalic = false;
  bool isUnderline = false;

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Toggle',
      description: 'A two-state button that can be either on or off.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Basic Usage', style: Theme.of(context).textTheme.titleSmall),
          const Gap(8),
          FpduiToggle(
            isPressed: isBold,
            onPressed: () => setState(() => isBold = !isBold),
            child: const Icon(LucideIcons.bold),
          ),
          const Gap(24),
          Text('Outline Variant', style: Theme.of(context).textTheme.titleSmall),
          const Gap(8),
          FpduiToggle(
            variant: FpduiToggleVariant.outline,
            isPressed: isItalic,
            onPressed: () => setState(() => isItalic = !isItalic),
            child: const Icon(LucideIcons.italic),
          ),
          const Gap(24),
          Text('Small Size', style: Theme.of(context).textTheme.titleSmall),
          const Gap(8),
          FpduiToggle(
            size: FpduiToggleSize.sm,
            isPressed: isUnderline,
            onPressed: () => setState(() => isUnderline = !isUnderline),
            child: const Icon(LucideIcons.underline, size: 16),
          ),
          const Gap(24),
          Text('With Text', style: Theme.of(context).textTheme.titleSmall),
          const Gap(8),
          FpduiToggle(
            isPressed: isBold,
            onPressed: () => setState(() => isBold = !isBold),
            child: const Text('Bold'),
          ),
        ],
      ),
    );
  }
}
