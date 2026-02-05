/// Responsible for displaying documentation for Switch component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: switch.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/switch.dart';
import '../../components/label.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key});

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  bool _airplaneMode = false;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Switch')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Default Switch', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            Row(
              children: [
                FpduiSwitch(
                  value: _airplaneMode, 
                  onChanged: (val) => setState(() => _airplaneMode = val),
                ),
                const Gap(12),
                const FpduiLabel('Airplane Mode'),
              ],
            ),
            
            const Gap(32),
            const Text('Form Example', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   const Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       FpduiLabel('Marketing emails'),
                       Gap(4),
                       Text('Receive emails about new products.', style: TextStyle(fontSize: 12, color: Colors.grey)),
                     ],
                   ),
                   FpduiSwitch(
                     value: _notifications,
                     onChanged: (val) => setState(() => _notifications = val),
                   ),
                ],
              ),
            ),

            const Gap(32),
            const Text('Disabled', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            Row(
              children: [
                 FpduiSwitch(value: false, enabled: false, onChanged: (v){}),
                 const Gap(12),
                 const FpduiLabel('Disabled unchecked'),
              ],
            ),
            const Gap(16),
            Row(
              children: [
                 FpduiSwitch(value: true, enabled: false, onChanged: (v){}),
                 const Gap(12),
                 const FpduiLabel('Disabled checked'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
