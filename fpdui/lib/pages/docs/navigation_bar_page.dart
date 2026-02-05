/// Responsible for displaying documentation for NavigationBar.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: navigation_bar.dart, component_page.
import 'package:flutter/material.dart';
import '../../components/navigation_bar.dart';
import 'component_page.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Navigation Bar',
      description: 'Material 3 Navigation Bar for switching between primary destinations.',
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: Scaffold(
          body: Center(
            child: Text('Selected Index: $_selectedIndex'),
          ),
          bottomNavigationBar: FpduiNavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) => setState(() => _selectedIndex = index),
            destinations: const [
              NavigationDestination(
                icon: Icon(LucideIcons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(LucideIcons.search),
                label: 'Search',
              ),
              NavigationDestination(
                icon: Icon(LucideIcons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
