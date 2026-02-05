/// Responsible for displaying documentation for Menubar component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: menubar.dart, dropdown_menu.dart, component_page.
import 'package:flutter/material.dart';
import '../../components/menubar.dart';
import '../../components/dropdown_menu.dart';
import 'component_page.dart';

class MenubarPage extends StatelessWidget {
  const MenubarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Menubar',
      description: 'A visually persistent menu bar typically located at the top of the screen.',
      child: Center(
        child: FpduiMenubar(
          children: [
            FpduiMenubarItem(
              label: 'File',
              children: [
                const FpduiDropdownMenuItem(child: Text('New Tab'), trailing: Text('⌘T')),
                const FpduiDropdownMenuItem(child: Text('New Window'), trailing: Text('⌘N')),
                const FpduiDropdownMenuItem(child: Text('New Incognito Window'), disabled: true),
                const FpduiDropdownMenuSeparator(),
                const FpduiDropdownMenuItem(child: Text('Share')),
                const FpduiDropdownMenuSeparator(),
                const FpduiDropdownMenuItem(child: Text('Print...'), trailing: Text('⌘P')),
              ],
            ),
            FpduiMenubarItem(
              label: 'Edit',
              children: [
                const FpduiDropdownMenuItem(child: Text('Undo'), trailing: Text('⌘Z')),
                const FpduiDropdownMenuItem(child: Text('Redo'), trailing: Text('⇧⌘Z')),
                const FpduiDropdownMenuSeparator(),
                const FpduiDropdownMenuItem(child: Text('Cut'), trailing: Text('⌘X')),
                const FpduiDropdownMenuItem(child: Text('Copy'), trailing: Text('⌘C')),
                const FpduiDropdownMenuItem(child: Text('Paste'), trailing: Text('⌘V')),
              ],
            ),
             FpduiMenubarItem(
              label: 'View',
              children: [
                const FpduiDropdownMenuItem(child: Text('Always Show Bookmarks Bar')), 
                const FpduiDropdownMenuItem(child: Text('Always Show Full URLs')),
                const FpduiDropdownMenuSeparator(),
                const FpduiDropdownMenuItem(child: Text('Reload'), trailing: Text('⌘R')),
                const FpduiDropdownMenuItem(child: Text('Force Reload'), trailing: Text('⇧⌘R')),
                const FpduiDropdownMenuSeparator(),
                const FpduiDropdownMenuItem(child: Text('Toggle Full Screen')),
              ],
            ),
             FpduiMenubarItem(
              label: 'Profiles',
              children: [
                const FpduiDropdownMenuItem(child: Text('Andy')),
                const FpduiDropdownMenuItem(child: Text('Benoit')),
                const FpduiDropdownMenuItem(child: Text('Luis')),
                const FpduiDropdownMenuSeparator(),
                const FpduiDropdownMenuItem(child: Text('Edit...')),
                const FpduiDropdownMenuSeparator(),
                const FpduiDropdownMenuItem(child: Text('Add Profile...')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
