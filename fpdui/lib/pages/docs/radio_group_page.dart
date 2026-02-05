/// Responsible for displaying documentation for Radio Group component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: radio_group.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/radio_group.dart';
import '../../components/label.dart';

class RadioGroupPage extends StatefulWidget {
  const RadioGroupPage({super.key});

  @override
  State<RadioGroupPage> createState() => _RadioGroupPageState();
}

class _RadioGroupPageState extends State<RadioGroupPage> {
  String _selectedOption = 'default';
  String _density = 'comfortable';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Radio Group')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Default', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            FpduiRadioGroup<String>(
              value: _selectedOption,
              onChanged: (val) => setState(() => _selectedOption = val!),
              children: [
                 Row(
                   children: [
                     const FpduiRadioGroupItem(value: 'default'),
                     const Gap(8),
                     const FpduiLabel('Default'),
                   ],
                 ),
                 Row(
                   children: [
                      const FpduiRadioGroupItem(value: 'comfortable'),
                      const Gap(8),
                      const FpduiLabel('Comfortable'),
                   ],
                 ),
                 Row(
                   children: [
                      const FpduiRadioGroupItem(value: 'compact'),
                      const Gap(8),
                      const FpduiLabel('Compact'),
                   ],
                 ),
              ],
            ),
            
            const Gap(32),
            const Text('Form Example', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
             FpduiRadioGroup<String>(
              value: _density,
              onChanged: (val) => setState(() => _density = val!),
              spacing: 16,
              children: [
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const Padding(
                       padding: EdgeInsets.only(top: 2.0),
                       child: FpduiRadioGroupItem(value: 'default'),
                     ),
                     const Gap(8),
                     const Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           FpduiLabel('Default'),
                           Text('Standard spacing for general use cases.', style: TextStyle(fontSize: 12, color: Colors.grey)),
                         ],
                       ),
                     ),
                   ],
                 ),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const Padding(
                       padding: EdgeInsets.only(top: 2.0),
                       child: FpduiRadioGroupItem(value: 'comfortable'),
                     ),
                     const Gap(8),
                     const Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           FpduiLabel('Comfortable'),
                           Text('More breathing room for content heavy layouts.', style: TextStyle(fontSize: 12, color: Colors.grey)),
                         ],
                       ),
                     ),
                   ],
                 ),
                 Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const Padding(
                       padding: EdgeInsets.only(top: 2.0),
                       child: FpduiRadioGroupItem(value: 'compact'),
                     ),
                     const Gap(8),
                     const Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           FpduiLabel('Compact'),
                           Text('Tight spacing for data density.', style: TextStyle(fontSize: 12, color: Colors.grey)),
                         ],
                       ),
                     ),
                   ],
                 ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
