/// Responsible for displaying documentation for List component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: list.dart, component_page.
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../components/list.dart';
// import '../../components/avatar.dart'; // If available
import 'component_page.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'List',
      description: 'A scrollable list with optional search and versatile list items.',
      child: SizedBox(
        height: 600, // Constrain height for demo
        child: FpduiList(
          enableSearch: true,
          onSearch: (value) {
            // Demo only: in real app, filter logic goes here
            debugPrint('Searching for: $value');
          },
          children: [
            FpduiListItem(
              leading: const CircleAvatar(child: Text('JD')), // Or FpduiAvatar
              title: const Text('John Doe'),
              subtitle: const Text('Software Engineer'),
              trailing: IconButton(icon: const Icon(LucideIcons.moreHorizontal), onPressed: () {}),
            ),
             FpduiListItem(
              leading: const CircleAvatar(child: Text('AS')), 
              title: const Text('Alice Smith'),
              subtitle: const Text('Product Manager'),
              trailing: IconButton(icon: const Icon(LucideIcons.moreHorizontal), onPressed: () {}),
            ),
             FpduiListItem(
              leading: const Icon(LucideIcons.mail),
              title: const Text('Inbox'),
              subtitle: const Text('12 Unread messages'),
               onTap: () {},
            ),
             FpduiListItem(
              leading: const Icon(LucideIcons.trash2),
              title: const Text('Trash'),
              isDestructive: true,
              trailing: const Text('Empty'),
               onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
