// Responsible for tabbed content switching.
// Provides FpduiTabs, TabsList, TabsTrigger, TabsContent.
//
// Used by: Dashboards, complex views.
// Depends on: fpdui_theme.
// Assumes: Shared value/controller for state.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../theme/fpdui_theme.dart';

class FpduiTabs extends StatelessWidget {
  const FpduiTabs({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
    required this.children,
    this.width,
  }) : assert(tabs.length == children.length, 'Tabs and children count must match');

  final List<String> tabs;
  final List<Widget> children;
  final int initialIndex;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return DefaultTabController(
      length: tabs.length,
      initialIndex: initialIndex,
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 40,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: fpduiTheme.muted,
                borderRadius: BorderRadius.circular(fpduiTheme.radius),
              ),
              child: TabBar(
                splashBorderRadius: BorderRadius.circular(fpduiTheme.radius - 2),
                indicator: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(fpduiTheme.radius - 2),
                  boxShadow: [
                    BoxShadow(
                      color: fpduiTheme.shadow,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelPadding: EdgeInsets.zero,
                labelColor: theme.colorScheme.onSurface,
                labelStyle: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelColor: fpduiTheme.mutedForeground,
                tabs: tabs.map((tab) => Tab(
                  height: 32,
                  text: tab,
                )).toList(),
              ),
            ),
            const Gap(16),
            SizedBox(
              height: 400, // Explicit bounded height for TabBarView
              child: TabBarView(
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
