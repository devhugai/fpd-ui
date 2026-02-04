import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/toast.dart';
import '../../components/button.dart';

class ToastPage extends StatelessWidget {
  const ToastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toast / Sonner')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             FpduiButton(
               text: 'Default Toast',
               variant: FpduiButtonVariant.outline,
               onPressed: () {
                 FpduiToast.show(
                   context, 
                   'Event has been created',
                   description: 'Sunday, December 03, 2023 at 9:00 AM',
                   action: FpduiButton(
                     text: 'Undo', 
                     variant: FpduiButtonVariant.outline, 
                     height: 24, // small button
                     onPressed: (){}
                   ),
                 );
               },
             ),
             const Gap(16),
             FpduiButton(
               text: 'Success Toast',
               variant: FpduiButtonVariant.outline,
               onPressed: () {
                 FpduiToast.show(
                   context, 
                   'Success!',
                   description: 'Your changes have been saved.',
                   variant: FpduiToastVariant.success,
                 );
               },
             ),
              const Gap(16),
             FpduiButton(
               text: 'Destructive Toast',
               variant: FpduiButtonVariant.destructive,
               onPressed: () {
                 FpduiToast.show(
                   context, 
                   'Error',
                   description: 'There was a problem with your request.',
                   variant: FpduiToastVariant.destructive,
                 );
               },
             ),
          ],
        ),
      ),
    );
  }
}
