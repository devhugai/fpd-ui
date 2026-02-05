/// Responsible for displaying documentation for Tooltip component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: tooltip.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/tooltip.dart';
import '../../components/button.dart';

class TooltipPage extends StatelessWidget {
  const TooltipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tooltip')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FpduiTooltip(
              message: 'Add to library',
              child: FpduiButton(
                text: 'Hover me',
                variant: FpduiButtonVariant.outline,
                onPressed: () {},
              ),
            ),
            const Gap(32),
            const Text('Different positions:'),
            const Gap(16),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 FpduiTooltip(
                   message: 'Top tooltip',
                   side: AxisDirection.up,
                   child: FpduiButton(text: 'Top', variant: FpduiButtonVariant.ghost, onPressed: (){}),
                 ),
                 FpduiTooltip(
                   message: 'Bottom tooltip',
                   side: AxisDirection.down,
                   child: FpduiButton(text: 'Bottom', variant: FpduiButtonVariant.ghost, onPressed: (){}),
                 ),
                 FpduiTooltip(
                   message: 'Left tooltip',
                   side: AxisDirection.left,
                   child: FpduiButton(text: 'Left', variant: FpduiButtonVariant.ghost, onPressed: (){}),
                 ),
                  FpduiTooltip(
                   message: 'Right tooltip',
                   side: AxisDirection.right,
                   child: FpduiButton(text: 'Right', variant: FpduiButtonVariant.ghost, onPressed: (){}),
                 ),
               ],
             ),
          ],
        ),
      ),
    );
  }
}
