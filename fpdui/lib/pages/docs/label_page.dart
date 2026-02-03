import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/label.dart';

class LabelPage extends StatelessWidget {
  const LabelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Label')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Default Label', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
             const FpduiLabel('Your email address'),
             
             const Gap(32),
             const Text('Required Label', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
             const Gap(16),
             const FpduiLabel('Password', required: true),

            const Gap(32),
            const Text('With Context', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FpduiLabel('Full Name'),
                const Gap(8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('Input placeholder...', style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
