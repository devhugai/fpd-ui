// Responsible for display tabbed navigation.
// Provides FpduiTabBar.
//
// Used by: Scaffolds, TabBarView.
// Depends on: fpdui_theme.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiTabBar extends StatelessWidget {
  const FpduiTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.isScrollable = false,
    this.onTap,
  });

  final List<Widget> tabs;
  final TabController? controller;
  final bool isScrollable;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return TabBarTheme(
      data: TabBarThemeData(
        labelColor: theme.colorScheme.onSurface,
        unselectedLabelColor: theme.colorScheme.onSurface.withValues(alpha: 0.7),
        indicatorColor: fpduiTheme.primary, // Primary underline
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: fpduiTheme.border,
        labelStyle: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.normal),
      ),
      child: TabBar(
        controller: controller,
        tabs: tabs,
        isScrollable: isScrollable,
        onTap: onTap,
        indicatorWeight: 2,
      ),
    );
  }
}
