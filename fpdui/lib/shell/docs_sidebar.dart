/// Responsible for the documentation navigation sidebar.
/// Provides links to all documentation sections.
///
/// Used by: DocsShell.
/// Depends on: go_router, fpdui_theme.
/// Assumes: Fixed navigation structure.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../components/button.dart';
import '../theme/fpdui_theme.dart';

import '../components/input.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DocsSidebarContent extends StatefulWidget {
  const DocsSidebarContent({super.key});

  @override
  State<DocsSidebarContent> createState() => _DocsSidebarContentState();
}

class _DocsSidebarContentState extends State<DocsSidebarContent> {
  String _searchQuery = '';

  final List<_SidebarGroupData> _allGroups = [
    _SidebarGroupData(
      title: "Getting Started",
      items: [
        _SidebarItem(title: "Introduction", path: "/docs/introduction"),
        _SidebarItem(title: "Installation", path: "/docs/installation"),
        _SidebarItem(title: "Typography", path: "/docs/typography"),
      ],
    ),
    _SidebarGroupData(
      title: "Primitives",
      items: [
        _SidebarItem(title: "Button", path: "/docs/components/button"),
        _SidebarItem(title: "FAB", path: "/docs/components/fab"),
        _SidebarItem(title: "Badge", path: "/docs/components/badge"),
        _SidebarItem(title: "Avatar", path: "/docs/components/avatar"),
        _SidebarItem(title: "Card", path: "/docs/components/card"),
        _SidebarItem(title: "Separator", path: "/docs/components/separator"),
        _SidebarItem(title: "Skeleton", path: "/docs/components/skeleton"),
        _SidebarItem(title: "Label", path: "/docs/components/label"),
        _SidebarItem(title: "List", path: "/docs/components/list"),
      ],
    ),
    _SidebarGroupData(
      title: "Inputs & Forms",
      items: [
        _SidebarItem(title: "Input", path: "/docs/components/input"),
        _SidebarItem(title: "Input OTP", path: "/docs/components/input-otp"),
        _SidebarItem(title: "Textarea", path: "/docs/components/textarea"),
        _SidebarItem(title: "Checkbox", path: "/docs/components/checkbox"),
        _SidebarItem(title: "Combobox", path: "/docs/components/combobox"),
        _SidebarItem(title: "Switch", path: "/docs/components/switch"),
        _SidebarItem(title: "Radio Group", path: "/docs/components/radio-group"),
        _SidebarItem(title: "Select", path: "/docs/components/select"),
        _SidebarItem(title: "Slider", path: "/docs/components/slider"),
        _SidebarItem(title: "Toggle", path: "/docs/components/toggle"),
        _SidebarItem(title: "Toggle Group", path: "/docs/components/toggle-group"),
         // _SidebarItem(title: "Progress", path: "/docs/components/progress"), 
        _SidebarItem(title: "Form", path: "/docs/components/form"),
        _SidebarItem(title: "Date Picker", path: "/docs/components/date-picker"),
      ],
    ),
    _SidebarGroupData(
      title: "Overlays & Feedback",
      items: [
        _SidebarItem(title: "Alert", path: "/docs/components/alert"),
        _SidebarItem(title: "Alert Dialog", path: "/docs/components/alert-dialog"),
        _SidebarItem(title: "Context Menu", path: "/docs/components/context-menu"),
        _SidebarItem(title: "Dialog", path: "/docs/components/dialog"),
        _SidebarItem(title: "Drawer", path: "/docs/components/drawer"),
        _SidebarItem(title: "Dropdown Menu", path: "/docs/components/dropdown-menu"),
        _SidebarItem(title: "Hover Card", path: "/docs/components/hover-card"),
        _SidebarItem(title: "Popover", path: "/docs/components/popover"),
        _SidebarItem(title: "Sheet", path: "/docs/components/sheet"),
        _SidebarItem(title: "Snackbar", path: "/docs/components/snackbar"),
        _SidebarItem(title: "Spinner", path: "/docs/components/spinner"),
        _SidebarItem(title: "Toast", path: "/docs/components/toast"),
        _SidebarItem(title: "Tooltip", path: "/docs/components/tooltip"),
      ],
    ),
    _SidebarGroupData(
      title: "Navigation & Layout",
      items: [
        _SidebarItem(title: "Accordion", path: "/docs/components/accordion"),
        _SidebarItem(title: "Aspect Ratio", path: "/docs/components/aspect-ratio"),
        _SidebarItem(title: "Collapsible", path: "/docs/components/collapsible"),
        _SidebarItem(title: "Menubar", path: "/docs/components/menubar"),
        _SidebarItem(title: "Tabs", path: "/docs/components/tabs"),
        _SidebarItem(title: "Scroll Area", path: "/docs/components/scroll-area"),
        _SidebarItem(title: "Resizable", path: "/docs/components/resizable"),
        _SidebarItem(title: "Sidebar", path: "/docs/components/sidebar"),
        _SidebarItem(title: "Navigation Menu", path: "/docs/components/navigation-menu"), // Check if route exists
        // _SidebarItem(title: "Breadcrumb", path: "/docs/components/breadcrumb"), 
        _SidebarItem(title: "Pagination", path: "/docs/components/pagination"),
      ],
    ),
    _SidebarGroupData(
      title: "Data Display",
      items: [
        _SidebarItem(title: "Table", path: "/docs/components/table"),
        _SidebarItem(title: "Data Table", path: "/docs/components/data-table"),
        _SidebarItem(title: "Command", path: "/docs/components/command"),
        _SidebarItem(title: "Kbd", path: "/docs/components/kbd"),
        _SidebarItem(title: "Calendar", path: "/docs/components/calendar"),
        _SidebarItem(title: "Chart", path: "/docs/components/chart"),
        _SidebarItem(title: "Carousel", path: "/docs/components/carousel"),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    // Filter groups
    final filteredGroups = _allGroups.map((group) {
      if (_searchQuery.isEmpty) return group;
      
      final filteredItems = group.items.where((item) => 
        item.title.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
      
      if (filteredItems.isEmpty) return null;
      
      return _SidebarGroupData(title: group.title, items: filteredItems);
    }).whereType<_SidebarGroupData>().toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: FpduiInput(
            hintText: 'Search components...',
            prefix: const Icon(LucideIcons.search, size: 16),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...filteredGroups.map((group) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SidebarGroup(title: group.title, items: group.items),
                    const SizedBox(height: 24),
                  ],
                )),
                if (filteredGroups.isEmpty)
                   Padding(
                     padding: const EdgeInsets.only(top: 20),
                     child: Text(
                       'No results found.',
                       style: theme.textTheme.bodyMedium?.copyWith(
                         color: fpduiTheme.mutedForeground,
                       ),
                     ),
                   ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SidebarGroupData {
  final String title;
  final List<_SidebarItem> items;
  _SidebarGroupData({required this.title, required this.items});
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
