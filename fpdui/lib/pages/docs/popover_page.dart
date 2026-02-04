import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/popover.dart';
import '../../components/button.dart';
import '../../components/input.dart';
import '../../components/label.dart';

class PopoverPage extends StatelessWidget {
  const PopoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popover')),
      body: Center(
        child: FpduiPopover(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dimensions',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const Text(
                'Set the dimensions for the layer.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const Gap(16),
              const Row(
                children: [
                   SizedBox(width: 80, child: FpduiLabel('Width', textAlign: TextAlign.right)),
                   Gap(16),
                   Expanded(child: FpduiInput(hintText: '100%')),
                ],
              ),
              const Gap(8),
               const Row(
                children: [
                   SizedBox(width: 80, child: FpduiLabel('Max. width', textAlign: TextAlign.right)),
                   Gap(16),
                   Expanded(child: FpduiInput(hintText: '300px')),
                ],
              ),
              const Gap(8),
               const Row(
                children: [
                   SizedBox(width: 80, child: FpduiLabel('Height', textAlign: TextAlign.right)),
                   Gap(16),
                   Expanded(child: FpduiInput(hintText: '25px')),
                ],
              ),
              const Gap(8),
               const Row(
                children: [
                   SizedBox(width: 80, child: FpduiLabel('Max. height', textAlign: TextAlign.right)),
                   Gap(16),
                   Expanded(child: FpduiInput(hintText: 'none')),
                ],
              ),
            ],
          ),
          child: FpduiButton(
            text: 'Open Popover',
            variant: FpduiButtonVariant.outline,
            onPressed: () {}, // Handled by Popover internally via GestureDetector
          ),
        ),
      ),
    );
  }
}
