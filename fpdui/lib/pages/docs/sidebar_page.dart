/// Responsible for displaying documentation for Sidebar component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: sidebar.dart, component_page.
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../components/sidebar.dart';
import '../../components/avatar.dart';
import '../../components/separator.dart';

class SidebarPage extends StatelessWidget {
  const SidebarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FpduiSidebarProvider(
      child: Scaffold(
        body: Row(
          children: [
            FpduiSidebar(
              collapsible: FpduiSidebarCollapsible.icon,
              children: [
                FpduiSidebarHeader(
                  child: Row(
                    children: [
                      const FpduiAvatar(
                         image: NetworkImage('https://github.com/shadcn.png'),
                         fallback: Text('SC'),
                         size: FpduiAvatarSize.sm,
                      ),
                      const SizedBox(width: 8),
                      // Only show text if expaned check effectively done inside widgets if we had state access, 
                      // but here we rely on OverflowBox/ClipRect in Sidebar to hide overflow.
                      // Ideally SidebarHeader contents should also adapt? 
                      // For now, let's keep it simple.
                      Expanded(
                        child: Text(
                          'Acme Inc',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const FpduiSidebarSeparator(),
                 FpduiSidebarContent(
                  children: [
                    FpduiSidebarGroup(
                      children: [
                        const FpduiSidebarGroupLabel('Platform'),
                        FpduiSidebarMenu(
                          children: [
                            FpduiSidebarMenuItem(
                              child: FpduiSidebarMenuButton(
                                icon: const Icon(LucideIcons.home),
                                tooltip: 'Home',
                                isActive: true,
                                onTap: () {},
                                child: const Text('Home'),
                              ),
                            ),
                            FpduiSidebarMenuItem(
                              child: FpduiSidebarMenuButton(
                                icon: const Icon(LucideIcons.inbox),
                                tooltip: 'Inbox',
                                onTap: () {},
                                child: const Text('Inbox'),
                              ),
                            ),
                             FpduiSidebarMenuItem(
                              child: FpduiSidebarMenuButton(
                                icon: const Icon(LucideIcons.calendar),
                                tooltip: 'Calendar',
                                onTap: () {},
                                child: const Text('Calendar'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const FpduiSidebarGroup(
                      children: [
                        FpduiSidebarGroupLabel('Settings'),
                        FpduiSidebarMenuButton(
                           icon: Icon(LucideIcons.settings),
                           tooltip: 'Settings',
                           child: Text('Settings'),
                        ),
                      ],
                    ),
                  ],
                ),
                FpduiSidebarFooter(
                   child: Row(
                     children: [
                       const Icon(LucideIcons.user, size: 16),
                       const SizedBox(width: 8),
                       const Text('User Account'),
                     ],
                   ),
                ),
              ],
            ),
            FpduiSidebarInset(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: const FpduiSidebarTrigger(),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text('Main Content Area'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
