import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/checkbox.dart';
import '../../components/label.dart';

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  bool _termsAccepted = false;
  bool _disabledChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkbox')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Default Checkbox', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            Row(
              children: [
                FpduiCheckbox(
                  value: _termsAccepted, 
                  onChanged: (val) => setState(() => _termsAccepted = val),
                ),
                const Gap(8),
                const FpduiLabel('Accept terms and conditions'),
              ],
            ),
            
            const Gap(32),
            const Text('With Text', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FpduiCheckbox(
                  value: _termsAccepted,
                  onChanged: (val) => setState(() => _termsAccepted = val),
                ),
                const Gap(8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FpduiLabel('Accept terms and conditions'),
                      Gap(4),
                      Text(
                        'You agree to our Terms of Service and Privacy Policy.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Gap(32),
            const Text('Disabled', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            Row(
              children: [
                 FpduiCheckbox(value: false, enabled: false, onChanged: (v){}),
                 const Gap(8),
                 const FpduiLabel('Disabled unchecked'),
              ],
            ),
            const Gap(16),
            Row(
              children: [
                 FpduiCheckbox(value: true, enabled: false, onChanged: (v){}),
                 const Gap(8),
                 const FpduiLabel('Disabled checked'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
