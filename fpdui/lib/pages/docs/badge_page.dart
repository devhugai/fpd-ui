/// Responsible for displaying documentation for Badge component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: badge.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/badge.dart';

class BadgePage extends StatelessWidget {
  const BadgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Badge')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Variants', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                FpduiBadge.text('Primary', variant: FpduiBadgeVariant.primary),
                FpduiBadge.text('Secondary', variant: FpduiBadgeVariant.secondary),
                FpduiBadge.text('Destructive', variant: FpduiBadgeVariant.destructive),
                FpduiBadge.text('Outline', variant: FpduiBadgeVariant.outline),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
