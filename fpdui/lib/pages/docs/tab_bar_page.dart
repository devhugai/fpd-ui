/// Responsible for displaying documentation for TabBar.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: tab_bar.dart, component_page.
import 'package:flutter/material.dart';
import '../../components/tab_bar.dart';
import 'component_page.dart';

class TabBarPage extends StatelessWidget {
  const TabBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Tab Bar',
      description: 'Material Design tabs to switch between views.',
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const FpduiTabBar(
              tabs: [
                Tab(text: 'Photos'),
                Tab(text: 'Videos'),
                Tab(text: 'Albums'),
              ],
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.grey.withOpacity(0.2)),
                  right: BorderSide(color: Colors.grey.withOpacity(0.2)),
                  bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
                ),
              ),
              child: const TabBarView(
                children: [
                  Center(child: Text('Photos Content')),
                  Center(child: Text('Videos Content')),
                  Center(child: Text('Albums Content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
