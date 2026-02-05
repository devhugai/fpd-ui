/// Responsible for displaying documentation for Spinner component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: spinner.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/spinner.dart';
import 'component_page.dart';

class SpinnerPage extends StatelessWidget {
  const SpinnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'Spinner',
      description: 'Animated usage indicator.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FpduiSpinner(),
              Gap(24),
              FpduiSpinner(size: 32, color: Colors.blue),
              Gap(24),
              FpduiSpinner(size: 16, color: Colors.red),
            ],
          ),
        ],
      ),
    );
  }
}
