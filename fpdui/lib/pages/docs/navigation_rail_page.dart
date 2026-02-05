/// Responsible for displaying documentation for NavigationRail.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: navigation_rail.dart, component_page.
import 'package:flutter/material.dart';
import '../../components/navigation_rail.dart';
import 'component_page.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NavigationRailPage extends StatefulWidget {
  const NavigationRailPage({super.key});

  @override
  State<NavigationRailPage> createState() => _NavigationRailPageState();
}

class _NavigationRailPageState extends State<NavigationRailPage> {
  int _selectedIndex = 0;
  bool _extended = false;

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Navigation Rail',
      description: 'Side navigation rail for larger screens.',
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            FpduiNavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) => setState(() => _selectedIndex = index),
              extended: _extended,
              leading: IconButton(
                icon: Icon(_extended ? LucideIcons.chevronLeft : LucideIcons.menu),
                onPressed: () => setState(() => _extended = !_extended),
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(LucideIcons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(LucideIcons.search),
                  label: Text('Search'),
                ),
                NavigationRailDestination(
                  icon: Icon(LucideIcons.settings),
                  label: Text('Settings'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: Center(
                child: Text('Selected Index: $_selectedIndex'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
