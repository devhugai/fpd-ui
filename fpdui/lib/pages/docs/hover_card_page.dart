/// Responsible for displaying documentation for Hover Card component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: hover_card.dart, avatar.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../components/hover_card.dart';
import '../../components/avatar.dart';
import 'component_page.dart';

class HoverCardPage extends StatelessWidget {
  const HoverCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ComponentPage(
      name: 'Hover Card',
      description: 'For sighted users to preview content available behind a link.',
      child: Center(
        child: FpduiHoverCard(
          trigger: Text(
            '@flutterpilot',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              color: theme.colorScheme.primary, // Using primary for link look
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                   FpduiAvatar(
                    image: const NetworkImage('https://github.com/flutterpilot.png'), 
                    fallback: const Text('FP'),
                  ),
                  const Gap(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Flutter Pilot', style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold)),
                      Text('@flutterpilot', style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.onBackground.withOpacity(0.6))),
                    ],
                  ),
                ],
              ),
              const Gap(16),
              Text(
                'High-performance, accessible, and customizable UI components for Flutter.',
                style: theme.textTheme.bodyMedium,
              ),
              const Gap(16),
              Row(
                children: [
                  const Icon(LucideIcons.calendarDays, size: 16, color: Colors.grey),
                  const Gap(4),
                  Text('Joined December 2023', style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
