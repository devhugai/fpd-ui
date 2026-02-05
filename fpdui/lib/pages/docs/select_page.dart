/// Responsible for displaying documentation for Select component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: select.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/select.dart';
import 'component_page.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  String? selectedFruit;
  String? selectedTheme;

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Select',
      description: 'Displays a list of options for the user to pick from.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Basic Usage', style: Theme.of(context).textTheme.titleSmall),
          const Gap(8),
          FpduiSelect<String>(
            width: 200,
            value: selectedFruit,
            placeholder: const Text('Select a fruit'),
            onChanged: (val) {
              setState(() => selectedFruit = val);
            },
            items: const [
              FpduiSelectItem(value: 'apple', child: Text('Apple')),
              FpduiSelectItem(value: 'banana', child: Text('Banana')),
              FpduiSelectItem(value: 'blueberry', child: Text('Blueberry')),
              FpduiSelectItem(value: 'grapes', child: Text('Grapes')),
              FpduiSelectItem(value: 'pineapple', child: Text('Pineapple')),
            ],
          ),
          const Gap(24),
          Text('With Default Value', style: Theme.of(context).textTheme.titleSmall),
          const Gap(8),
           FpduiSelect<String>(
            width: 200,
            value: selectedTheme ?? 'light',
            placeholder: const Text('Select theme'),
            onChanged: (val) {
              setState(() => selectedTheme = val);
            },
            items: const [
              FpduiSelectItem(value: 'light', child: Text('Light')),
              FpduiSelectItem(value: 'dark', child: Text('Dark')),
              FpduiSelectItem(value: 'system', child: Text('System')),
            ],
          ),
        ],
      ),
    );
  }
}
