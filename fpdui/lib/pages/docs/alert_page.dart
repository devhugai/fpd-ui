/// Responsible for displaying documentation for Alert component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: alert.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../components/alert.dart';
import 'component_page.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Alert',
      description: 'Displays a callout for user attention.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVariant(
            context,
            'Default',
            const FpduiAlert(
              icon: LucideIcons.terminal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FpduiAlertTitle('Heads up!'),
                  FpduiAlertDescription('You can add components to your app using the cli.'),
                ],
              ),
            ),
          ),
          const Gap(24),
          _buildVariant(
            context,
            'Destructive',
            const FpduiAlert(
              variant: FpduiAlertVariant.destructive,
              icon: LucideIcons.alertCircle,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FpduiAlertTitle('Error'),
                  FpduiAlertDescription('Your session has expired. Please log in again.'),
                ],
              ),
            ),
          ),
          const Gap(24),
          _buildVariant(
            context,
            'Warning',
            const FpduiAlert(
              variant: FpduiAlertVariant.warning,
              icon: LucideIcons.alertTriangle,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FpduiAlertTitle('Warning'),
                  FpduiAlertDescription('This action cannot be undone.'),
                ],
              ),
            ),
          ),
          const Gap(24),
          _buildVariant(
            context,
            'Success',
            const FpduiAlert(
              variant: FpduiAlertVariant.success,
              icon: LucideIcons.checkCircle,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FpduiAlertTitle('Success'),
                  FpduiAlertDescription('Your changes have been saved successfully.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVariant(BuildContext context, String name, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: Theme.of(context).textTheme.titleSmall),
        const Gap(8),
        child,
      ],
    );
  }
}
