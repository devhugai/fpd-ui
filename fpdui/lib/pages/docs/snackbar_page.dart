/// Responsible for displaying documentation for Snackbar component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: snackbar.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/snackbar.dart'; // Ensure filename matches component
import '../../components/button.dart';
import 'component_page.dart';

class SnackbarPage extends StatelessWidget {
  const SnackbarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Snackbar',
      description: 'A lightweight message with an optional action, using ScaffoldMessenger.',
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          FpduiButton(
            child: const Text('Show Default'),
            onPressed: () {
              FpduiSnackbar.show(
                context,
                title: 'Event Created',
                description: 'Your event has been scheduled.',
                actionLabel: 'Undo',
                onAction: () {},
              );
            },
          ),
          FpduiButton(
            variant: FpduiButtonVariant.destructive,
            child: const Text('Show Destructive'),
            onPressed: () {
              FpduiSnackbar.show(
                context,
                title: 'Deletion Failed',
                description: 'Could not delete the item. Please try again.',
                variant: FpduiSnackbarVariant.destructive,
              );
            },
          ),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            child: const Text('Show Success'),
            onPressed: () {
              FpduiSnackbar.show(
                context,
                title: 'Saved',
                variant: FpduiSnackbarVariant.success,
              );
            },
          ),
        ],
      ),
    );
  }
}
