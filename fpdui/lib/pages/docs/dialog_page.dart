import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/dialog.dart';
import '../../components/button.dart';
import '../../components/input.dart';
import '../../components/label.dart';

class DialogPage extends StatelessWidget {
  const DialogPage({super.key});

  void _showExampleDialog(BuildContext context) {
    FpduiDialog.show(
      context: context,
      child: FpduiDialogContent(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FpduiDialogHeader(
              children: [
                FpduiDialogTitle('Edit profile'),
                FpduiDialogDescription(
                  "Make changes to your profile here. Click save when you're done.",
                ),
              ],
            ),
             const Gap(24),
             const Column(
               children: [
                 Row(
                   children: [
                     SizedBox(width: 80, child: FpduiLabel('Name', textAlign: TextAlign.right)),
                     Gap(16),
                     Expanded(child: FpduiInput(hintText: 'Pedro Duarte')),
                   ],
                 ),
                 Gap(16),
                 Row(
                   children: [
                     SizedBox(width: 80, child: FpduiLabel('Username', textAlign: TextAlign.right)),
                      Gap(16),
                     Expanded(child: FpduiInput(hintText: '@peduarte')),
                   ],
                 ),
               ],
             ),
             FpduiDialogFooter(
               children: [
                 FpduiButton(
                   text: 'Save changes',
                   onPressed: () => Navigator.of(context).pop(),
                 ),
               ],
             ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    FpduiDialog.show(
      context: context,
      child: FpduiDialogContent(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FpduiDialogHeader(
              children: [
                FpduiDialogTitle('Are you sure absolutely sure?'),
                FpduiDialogDescription(
                  "This action cannot be undone. This will permanently delete your account and remove your data from our servers.",
                ),
              ],
            ),
             FpduiDialogFooter(
               children: [
                 FpduiButton(
                   text: 'Cancel',
                   variant: FpduiButtonVariant.outline,
                   onPressed: () => Navigator.of(context).pop(),
                 ),
                 FpduiButton(
                   text: 'Delete',
                   variant: FpduiButtonVariant.destructive,
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
      appBar: AppBar(title: const Text('Dialog')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FpduiButton(
              text: 'Edit Profile Dialog',
              variant: FpduiButtonVariant.outline,
              onPressed: () => _showExampleDialog(context),
            ),
            const Gap(16),
            FpduiButton(
              text: 'Delete Account Dialog',
              variant: FpduiButtonVariant.destructive,
              onPressed: () => _showDeleteDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}
