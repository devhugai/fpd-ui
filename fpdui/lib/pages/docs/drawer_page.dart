/// Responsible for displaying documentation for Drawer component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: drawer.dart, component_page.
import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
import '../../components/drawer.dart';
import '../../components/button.dart';
import 'component_page.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Drawer',
      description: 'A draggable dialog that comes up from the bottom of the screen.',
      child: FpduiButton(
        child: const Text('Open Drawer'),
        onPressed: () {
          FpduiDrawer.show(
            context: context,
            content: Column(
              children: [
                const FpduiDrawerHeader(
                  title: 'Move Goal',
                  description: 'Set your daily activity goal.',
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text('Content goes here', 
                    style: Theme.of(context).textTheme.displayMedium),
                ),
                FpduiDrawerFooter(
                  children: [
                    FpduiButton(child: const Text('Submit'), onPressed: () => Navigator.pop(context)),
                    FpduiButton(
                      variant: FpduiButtonVariant.outline,
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
