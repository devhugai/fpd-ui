/// Responsible for displaying documentation for NavigationDrawer.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: navigation_drawer.dart, component_page.
import 'package:flutter/material.dart';
import '../../components/navigation_drawer.dart';
import 'component_page.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NavigationDrawerPage extends StatefulWidget {
  const NavigationDrawerPage({super.key});

  @override
  State<NavigationDrawerPage> createState() => _NavigationDrawerPageState();
}

class _NavigationDrawerPageState extends State<NavigationDrawerPage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Navigation Drawer',
      description: 'Modal or standard drawer for navigation.',
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('With Drawer'),
            leading: IconButton(
              icon: const Icon(LucideIcons.menu),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),
          drawer: FpduiNavigationDrawer(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() => _selectedIndex = index);
              Navigator.pop(context); // Close drawer
            },
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
                child: Text('Header'),
              ),
              NavigationDrawerDestination(
                icon: Icon(LucideIcons.home),
                label: Text('Home'),
              ),
              NavigationDrawerDestination(
                icon: Icon(LucideIcons.messageSquare),
                label: Text('Messages'),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
                child: Divider(),
              ),
              NavigationDrawerDestination(
                icon: Icon(LucideIcons.settings),
                label: Text('Settings'),
              ),
            ],
          ),
          body: const Center(
            child: Text('Click menu icon to open drawer'),
          ),
        ),
      ),
    );
  }
}
