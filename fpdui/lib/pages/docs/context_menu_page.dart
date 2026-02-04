import 'package:flutter/material.dart';
import '../../components/context_menu.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ContextMenuPage extends StatelessWidget {
  const ContextMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Context Menu')),
      body: Center(
        child: FpduiContextMenu(
          items: [
             const FpduiContextMenuLabel('Actions'),
             FpduiContextMenuItem(
               child: const Text('Back'),
               leading: const Icon(LucideIcons.arrowLeft),
               trailing: const FpduiContextMenuShortcut('⌘['),
               onTap: () {},
             ),
             FpduiContextMenuItem(
               child: const Text('Forward'),
               leading: const Icon(LucideIcons.arrowRight),
               trailing: const FpduiContextMenuShortcut('⌘]'),
               disabled: true,
               onTap: () {},
             ),
             FpduiContextMenuItem(
               child: const Text('Reload'),
               leading: const Icon(LucideIcons.refreshCw),
               trailing: const FpduiContextMenuShortcut('⌘R'),
               onTap: () {},
             ),
             const FpduiContextMenuSeparator(), // Note: might need special handling in FpduiContextMenu map
             FpduiContextMenuItem(
               child: const Text('Save As...'),
               trailing: const FpduiContextMenuShortcut('⇧⌘S'),
               inset: true,
               onTap: () {},
             ),
          ],
          child: Container(
            height: 150,
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white, // Or theme background
            ),
            child: const Center(
              child: Text('Right click here'),
            ),
          ),
        ),
      ),
    );
  }
}
