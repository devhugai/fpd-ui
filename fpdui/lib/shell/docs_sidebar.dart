import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../components/button.dart';
import '../theme/fpdui_theme.dart';

class DocsSidebarContent extends StatelessWidget {
  const DocsSidebarContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SidebarGroup(
            title: "Getting Started",
            items: [
              _SidebarItem(title: "Introduction", path: "/docs/introduction"),
              _SidebarItem(title: "Installation", path: "/docs/installation"),
            ],
          ),
          const SizedBox(height: 24),
          _SidebarGroup(
            title: "Components",
            items: [
              _SidebarItem(title: "Button", path: "/docs/components/button"),
              _SidebarItem(title: "Card", path: "/docs/components/card"),
              _SidebarItem(title: "Input", path: "/docs/components/input"),
              _SidebarItem(title: "Table", path: "/docs/components/table"),
              _SidebarItem(title: "DataTable", path: "/docs/components/data-table"),
              _SidebarItem(title: "Command", path: "/docs/components/command"),
              _SidebarItem(title: "Calendar", path: "/docs/components/calendar"),
              _SidebarItem(title: "Chart", path: "/docs/components/chart"),
              _SidebarItem(title: "Carousel", path: "/docs/components/carousel"),
              // Add other components here
            ],
          ),
        ],
      ),
    );
  }
}

class _SidebarGroup extends StatelessWidget {
  const _SidebarGroup({required this.title, required this.items});
  final String title;
  final List<_SidebarItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => _SidebarLink(item: item)),
      ],
    );
  }
}

class _SidebarItem {
  final String title;
  final String path;
  _SidebarItem({required this.title, required this.path});
}

class _SidebarLink extends StatelessWidget {
  const _SidebarLink({required this.item});
  final _SidebarItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    final location = GoRouterState.of(context).uri.toString();
    final isActive = location == item.path;

    return InkWell(
      onTap: () => context.go(item.path),
      borderRadius: BorderRadius.circular(fpduiTheme.radius),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? fpduiTheme.accent : null,
          borderRadius: BorderRadius.circular(fpduiTheme.radius),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  fontSize: 14,
                  color: isActive ? fpduiTheme.accentForeground : fpduiTheme.mutedForeground,
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
