import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../components/navigation_menu.dart';
import '../../components/card.dart';

class NavigationMenuPage extends StatelessWidget {
  const NavigationMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Menu')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            FpduiNavigationMenu(
              children: [
                FpduiNavigationMenuItem(
                  trigger: const FpduiNavigationMenuTrigger(child: Text('Getting Started')),
                  content: FpduiNavigationMenuContent(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FpduiNavigationMenuLink(
                          title: 'Introduction',
                          description: 'Re-usable components built using Radix UI and Tailwind CSS.',
                          icon: const Icon(LucideIcons.rocket),
                          onTap: () {},
                        ),
                         FpduiNavigationMenuLink(
                          title: 'Installation',
                          description: 'How to install dependencies and structure your app.',
                          onTap: () {},
                        ),
                         FpduiNavigationMenuLink(
                          title: 'Typography',
                          description: 'Styles for headings, paragraphs, lists...etc',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                FpduiNavigationMenuItem(
                  trigger: const FpduiNavigationMenuTrigger(child: Text('Components')),
                  content: FpduiNavigationMenuContent(
                    child: SizedBox(
                      width: 400,
                      child: Wrap(
                        runSpacing: 8,
                        children: [
                          _buildGridLink('Alert Dialog', 'Modal dialog interrupts user.'),
                          _buildGridLink('Hover Card', 'Preview content available behind a link.'),
                          _buildGridLink('Progress', 'Displays an indicator showing completion progress.'),
                          _buildGridLink('Scroll-area', 'Visually or semantically separates content.'),
                          _buildGridLink('Tabs', 'A set of layered sections of content.'),
                          _buildGridLink('Tooltip', 'A popup that displays information related to an element.'),
                        ],
                      ),
                    ),
                  ),
                ),
                FpduiNavigationMenuItem(
                  trigger: TextButton(
                    onPressed: () {}, 
                    child: const Text('Documentation', style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridLink(String title, String desc) {
    return SizedBox(
      width: 190,
      child: FpduiNavigationMenuLink(
        title: title,
        description: desc,
        onTap: () {},
      ),
    );
  }
}
