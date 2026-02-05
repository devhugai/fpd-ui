/// Responsible for displaying documentation for Input component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: input.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/input.dart';
import '../../components/button.dart';
import '../../components/label.dart';

class InputPage extends StatelessWidget {
  const InputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Default Input', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            const FpduiInput(hintText: 'Email'),
            
            const Gap(32),
            const Text('File', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
             const Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 FpduiLabel('Picture'),
                 Gap(8),
                 FpduiInput(hintText: 'Choose file... (simulated)'),
               ],
             ),

            const Gap(32),
            const Text('Disabled', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            const FpduiInput(hintText: 'Email', enabled: false),

            const Gap(32),
            const Text('With Label', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
             const Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 FpduiLabel('Email'),
                 Gap(8),
                 FpduiInput(hintText: 'Email'),
               ],
             ),

             const Gap(32),
            const Text('With Button', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
             Row(
               children: [
                 const Expanded(child: FpduiInput(hintText: 'Email')),
                 const Gap(16),
                 FpduiButton(text: 'Subscribe', onPressed: (){}),
               ],
             ),

             const Gap(32),
            const Text('Form', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                   const FpduiLabel('Username'),
                   const Gap(8),
                   const FpduiInput(hintText: 'shadcn'),
                   const Gap(4),
                   Text('This is your public display name.', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
               ],
             ),
          ],
        ),
      ),
    );
  }
}
