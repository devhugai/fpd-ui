/// Responsible for displaying documentation for Combobox component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: combobox.dart, component_page.
import 'package:flutter/material.dart';
import '../../components/combobox.dart';
import 'component_page.dart';

class ComboboxPage extends StatefulWidget {
  const ComboboxPage({super.key});

  @override
  State<ComboboxPage> createState() => _ComboboxPageState();
}

class _ComboboxPageState extends State<ComboboxPage> {
  String? _framework;

  static const _frameworks = [
    ComboboxItem(value: 'next.js', label: 'Next.js'),
    ComboboxItem(value: 'sveltekit', label: 'SvelteKit'),
    ComboboxItem(value: 'nuxt.js', label: 'Nuxt.js'),
    ComboboxItem(value: 'remix', label: 'Remix'),
    ComboboxItem(value: 'astro', label: 'Astro'),
  ];

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Combobox',
      description: 'Autocomplete input and command palette with a list of suggestions.',
      child: Center(
        child: Column(
          children: [
            FpduiCombobox<String>(
              items: _frameworks,
              value: _framework,
              onChanged: (val) {
                setState(() => _framework = val);
                print("Selected: $val");
              },
              placeholder: "Select framework...",
            ),
            if (_framework != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Selected: $_framework'),
              ),
          ],
        ),
      ),
    );
  }
}
