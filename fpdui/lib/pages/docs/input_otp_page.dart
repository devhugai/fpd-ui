/// Responsible for displaying documentation for InputOTP component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: input_otp.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/input_otp.dart';
import 'component_page.dart';

class InputOTPPage extends StatefulWidget {
  const InputOTPPage({super.key});

  @override
  State<InputOTPPage> createState() => _InputOTPPageState();
}

class _InputOTPPageState extends State<InputOTPPage> {
  String otpValue = '';

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Input OTP',
      description: 'A component for entering one-time passwords.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Basic Usage', style: Theme.of(context).textTheme.titleSmall),
          const Gap(8),
          FpduiInputOTP(
            maxLength: 6,
            onChanged: (val) {
              setState(() => otpValue = val);
            },
          ),
          const Gap(8),
          Text('Value: $otpValue'),
          const Gap(24),
          Text('Grouped', style: Theme.of(context).textTheme.titleSmall),
           const Gap(8),
           // Example of grouping not easily fully composable via just children list in this simple impl, 
           // but keeping it simple for now. 
           // If I exposed controller or context-based slots it would be better.
           const Text("Grouping example pending API refinement."),
        ],
      ),
    );
  }
}
