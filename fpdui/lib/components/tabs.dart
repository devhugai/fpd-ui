import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiTabs extends StatefulWidget {
  const FpduiTabs({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
    required this.children,
    this.width,
  }) : assert(tabs.length == children.length, 'Tabs and children count must match');

  final List<String> tabs; // Labels for the tabs
  final List<Widget> children; // Content for the tabs
  final int initialIndex;
  final double? width;

  @override
  State<FpduiTabs> createState() => _FpduiTabsState();
}

class _FpduiTabsState extends State<FpduiTabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return SizedBox(
      width: widget.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tabs List Container
          Container(
            height: 40, // h-10 (approx 40px) normally h-9/h-10
            padding: const EdgeInsets.all(4), // p-1
            decoration: BoxDecoration(
              color: fpduiTheme.muted, // bg-muted
              borderRadius: BorderRadius.circular(fpduiTheme.radius), // rounded-md (or lg)
            ),
            child: TabBar(
              controller: _tabController,
              splashBorderRadius: BorderRadius.circular(fpduiTheme.radius - 2),
              indicator: BoxDecoration(
                color: theme.colorScheme.background, // bg-background (white/black)
                borderRadius: BorderRadius.circular(fpduiTheme.radius - 2), // rounded-sm
                boxShadow: [
                  BoxShadow(
                    color: fpduiTheme.shadow,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent, // Remove default divider
              labelPadding: EdgeInsets.zero,
              labelColor: theme.colorScheme.onBackground, // text-foreground
              labelStyle: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500, // font-medium
              ),
              unselectedLabelColor: fpduiTheme.mutedForeground, // text-muted-foreground
              tabs: widget.tabs.map((tab) => Tab(
                height: 32, // explicit height for centering
                text: tab,
              )).toList(),
            ),
          ),
          const SizedBox(height: 16), // gap-4 usually implies spacing between trigger list and content
          // Tabs Content
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
            child: SizedBox( // Sizing might be issue if content varies, but AnimatedSize helps.
              // Note: TabBarView forces fixed height or expanded. 
              // To have intrinsic height, we need a custom solution or use a simple Builder that listens to controller.
              // TabBarView is usually for full screens.
              // Let's use an AnimatedBuilder on the controller index to show just the active child.
              child: AnimatedBuilder(
                animation: _tabController,
                builder: (context, child) {
                  return widget.children[_tabController.index];
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
