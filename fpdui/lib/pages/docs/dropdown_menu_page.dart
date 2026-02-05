/// Responsible for displaying documentation for Dropdown Menu component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: dropdown_menu.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/dropdown_menu.dart';
import '../../components/button.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DropdownMenuPage extends StatelessWidget {
  const DropdownMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dropdown Menu')),
      body: Center(
        child: FpduiDropdownMenu(
          items: [
            const FpduiDropdownMenuLabel('My Account'),
            const FpduiDropdownMenuSeparator(),
            FpduiDropdownMenuItem(
              child: const Text('Profile'),
              leading: const Icon(LucideIcons.user),
              trailing: const FpduiDropdownMenuShortcut('⇧⌘P'),
              onTap: () {},
            ),
            FpduiDropdownMenuItem(
              child: const Text('Billing'),
              leading: const Icon(LucideIcons.creditCard),
              trailing: const FpduiDropdownMenuShortcut('⌘B'),
              onTap: () {},
            ),
            FpduiDropdownMenuItem(
              child: const Text('Settings'),
              leading: const Icon(LucideIcons.settings),
              trailing: const FpduiDropdownMenuShortcut('⌘S'),
              onTap: () {},
            ),
            FpduiDropdownMenuItem(
              child: const Text('Keyboard shortcuts'),
              leading: const Icon(LucideIcons.keyboard),
              trailing: const FpduiDropdownMenuShortcut('⌘K'),
              onTap: () {},
            ),
            const FpduiDropdownMenuSeparator(),
            FpduiDropdownMenuItem(
               child: const Text('Log out'),
               leading: const Icon(LucideIcons.logOut),
               trailing: const FpduiDropdownMenuShortcut('⇧⌘Q'),
               isDestructive: true,
               onTap: () {},
             ),
          ],
            trigger: AbsorbPointer(
              child: FpduiButton(
                text: 'Open',
                variant: FpduiButtonVariant.outline,
                onPressed: () {}, // Enable button visual state
              ),
            ),
        ),
      ),
    );
  }
}
