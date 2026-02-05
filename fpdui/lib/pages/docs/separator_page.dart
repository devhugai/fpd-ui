/// Responsible for displaying documentation for Separator component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: separator.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/separator.dart';

class SeparatorPage extends StatelessWidget {
  const SeparatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Separator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Horizontal', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            const Text('Above'),
            const Gap(16),
            const FpduiSeparator(),
            const Gap(16),
            const Text('Below'),
             const Gap(32),

            const Text('Vertical', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            SizedBox(
              height: 100,
              child: Row(
                children: [
                   const Text('Left'),
                   const Gap(16),
                   const FpduiSeparator(orientation: Axis.vertical),
                   const Gap(16),
                   const Text('Right'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
