/// Responsible for displaying documentation for Textarea component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: textarea.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/textarea.dart';
import '../../components/label.dart';
import '../../components/button.dart';

class TextareaPage extends StatelessWidget {
  const TextareaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Textarea')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Default Textarea', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            const FpduiTextarea(hintText: 'Type your message here.'),

            const Gap(32),
            const Text('With Text', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 FpduiLabel('Bio'),
                 Gap(8),
                 FpduiTextarea(
                   hintText: 'Tell us a little bit about yourself',
                   minLines: 4,
                 ),
                 Gap(4),
                 Text('You can @mention other users and organizations.', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),

            const Gap(32),
            const Text('Form', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FpduiTextarea(hintText: 'Type your message here.'),
                const Gap(16),
                FpduiButton(text: 'Send message', onPressed: () {}),
              ],
            ),

             const Gap(32),
            const Text('Disabled', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
             const FpduiTextarea(hintText: 'Type your message here.', enabled: false),
          ],
        ),
      ),
    );
  }
}
