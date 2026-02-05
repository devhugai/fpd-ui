/// Responsible for displaying documentation for AppBar and BottomAppBar.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: app_bar.dart, component_page.
import 'package:flutter/material.dart';
import '../../components/app_bar.dart';
import 'component_page.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AppBarPage extends StatelessWidget {
  const AppBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'App Bar',
      description: 'Container for top content and actions, and bottom navigation actions.',
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: Scaffold(
          appBar: FpduiAppBar(
            title: const Text('Page Title'),
            leading: IconButton(
              icon: const Icon(LucideIcons.menu),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                icon: const Icon(LucideIcons.user),
                onPressed: () {},
              )
            ],
          ),
          body: const Center(
            child: Text('Content Area'),
          ),
          bottomNavigationBar: FpduiBottomAppBar(
            child: Row(
              children: [
                IconButton(icon: const Icon(LucideIcons.home), onPressed: () {}),
                IconButton(icon: const Icon(LucideIcons.search), onPressed: () {}),
                const Spacer(),
                IconButton(icon: const Icon(LucideIcons.plus), onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
