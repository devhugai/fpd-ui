/// Responsible for displaying documentation for ToggleGroup (Segmented Button).
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: toggle_group.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../components/toggle_group.dart';
import 'component_page.dart';

class ToggleGroupPage extends StatefulWidget {
  const ToggleGroupPage({super.key});

  @override
  State<ToggleGroupPage> createState() => _ToggleGroupPageState();
}

class _ToggleGroupPageState extends State<ToggleGroupPage> {
  String? filter = 'daily';
  List<String> format = ['bold'];

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Toggle Group',
      description: 'A set of two-state buttons that can be toggled on or off.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Single Selection', style: Theme.of(context).textTheme.titleSmall),
          const Gap(8),
          FpduiToggleGroup<String>(
            value: filter,
            onChanged: (val) => setState(() => filter = val),
            items: const [
              FpduiToggleGroupItem(value: 'daily', child: Text('Daily')),
              FpduiToggleGroupItem(value: 'weekly', child: Text('Weekly')),
              FpduiToggleGroupItem(value: 'monthly', child: Text('Monthly')),
            ],
          ),
          const Gap(24),
          Text('Multiple Selection', style: Theme.of(context).textTheme.titleSmall),
          const Gap(8),
          FpduiToggleGroup<String>(
            type: FpduiToggleGroupType.multiple,
            value: format,
            onChanged: (val) => setState(() => format = val),
            items: const [
              FpduiToggleGroupItem(value: 'bold', child: Icon(LucideIcons.bold)),
              FpduiToggleGroupItem(value: 'italic', child: Icon(LucideIcons.italic)),
              FpduiToggleGroupItem(value: 'underline', child: Icon(LucideIcons.underline)),
            ],
          ),
        ],
      ),
    );
  }
}
