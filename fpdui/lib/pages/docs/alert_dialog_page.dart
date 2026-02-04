import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/alert_dialog.dart';
import '../../components/button.dart';

class AlertDialogPage extends StatelessWidget {
  const AlertDialogPage({super.key});

  void _showAlertDialog(BuildContext context) {
    FpduiAlertDialog.show(
      context: context,
      child: FpduiAlertDialogContent(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FpduiAlertDialogHeader(
              children: [
                FpduiAlertDialogTitle('Are you absolutely sure?'),
                FpduiAlertDialogDescription(
                  "This action cannot be undone. This will permanently delete your account and remove your data from our servers.",
                ),
              ],
            ),
             FpduiAlertDialogFooter(
               children: [
                 FpduiAlertDialogCancel(
                   onPressed: () => Navigator.of(context).pop(),
                 ),
                 FpduiButton( // Using generic button for custom styles like destructive
                   text: 'Continue',
                   onPressed: () => Navigator.of(context).pop(),
                 ),
               ],
             ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alert Dialog')),
      body: Center(
         child: FpduiButton(
           text: 'Show Alert Dialog',
           variant: FpduiButtonVariant.outline,
           onPressed: () => _showAlertDialog(context),
         ),
      ),
    );
  }
}
