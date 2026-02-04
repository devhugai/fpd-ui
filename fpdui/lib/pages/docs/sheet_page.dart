import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/sheet.dart';
import '../../components/button.dart';
import '../../components/label.dart';
import '../../components/input.dart';

class SheetPage extends StatelessWidget {
  const SheetPage({super.key});

  void _openSheet(BuildContext context, FpduiSheetSide side) {
    FpduiSheet.show(
      context: context,
      side: side,
      child: FpduiSheetContent(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FpduiSheetHeader(
              children: [
                FpduiSheetTitle('Edit profile'),
                FpduiSheetDescription("Make changes to your profile here. Click save when you're done."),
              ],
            ),
            const Column(
               children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     FpduiLabel('Name'),
                     Gap(8),
                     FpduiInput(hintText: 'Pedro Duarte'),
                   ],
                 ),
                 Gap(16),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                      FpduiLabel('Username'),
                      Gap(8),
                      FpduiInput(hintText: '@peduarte'),
                   ],
                 ),
               ],
             ),
             FpduiSheetFooter(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sheet')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  FpduiButton(
                    text: 'Open Top',
                    variant: FpduiButtonVariant.outline,
                    onPressed: () => _openSheet(context, FpduiSheetSide.top),
                  ),
                  FpduiButton(
                    text: 'Open Bottom',
                    variant: FpduiButtonVariant.outline,
                    onPressed: () => _openSheet(context, FpduiSheetSide.bottom),
                  ),
                  FpduiButton(
                    text: 'Open Left',
                    variant: FpduiButtonVariant.outline,
                    onPressed: () => _openSheet(context, FpduiSheetSide.left),
                  ),
                  FpduiButton(
                    text: 'Open Right',
                    variant: FpduiButtonVariant.outline,
                    onPressed: () => _openSheet(context, FpduiSheetSide.right),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
