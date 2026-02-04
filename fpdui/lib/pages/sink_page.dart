import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../components/button.dart';
import '../components/card.dart';
import '../components/badge.dart';
import 'docs/component_page.dart';

class SinkPage extends StatelessWidget {
  const SinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Kitchen Sink',
      description: 'Overview of all components in one place.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Buttons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Gap(16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FpduiButton(text: 'Primary', onPressed: () {}),
              FpduiButton(text: 'Secondary', variant: FpduiButtonVariant.secondary, onPressed: () {}),
              FpduiButton(text: 'Destructive', variant: FpduiButtonVariant.destructive, onPressed: () {}),
              FpduiButton(text: 'Outline', variant: FpduiButtonVariant.outline, onPressed: () {}),
              FpduiButton(text: 'Ghost', variant: FpduiButtonVariant.ghost, onPressed: () {}),
              FpduiButton(text: 'Link', variant: FpduiButtonVariant.link, onPressed: () {}),
            ],
          ),
          const Gap(32),
          const Text('Badges', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Gap(16),
          const Wrap(
            spacing: 8,
            children: [
              FpduiBadge(child: Text('Primary')),
              FpduiBadge(child: Text('Secondary'), variant: FpduiBadgeVariant.secondary),
              FpduiBadge(child: Text('Destructive'), variant: FpduiBadgeVariant.destructive),
              FpduiBadge(child: Text('Outline'), variant: FpduiBadgeVariant.outline),
            ],
          ),
          const Gap(32),
          const Text('Cards', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Gap(16),
          const FpduiCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FpduiCardHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FpduiCardTitle(child: Text('Notification')),
                      FpduiCardDescription(child: Text('You have a new message')),
                    ],
                  ),
                ),
                FpduiCardContent(child: Text('This is a card within the sink page.')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
