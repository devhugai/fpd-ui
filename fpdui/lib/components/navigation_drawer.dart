// Responsible for side drawer navigation.
// Provides FpduiNavigationDrawer.
//
// Used by: Scaffolds (drawer).
// Depends on: fpdui_theme.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiNavigationDrawer extends StatelessWidget {
  const FpduiNavigationDrawer({
    super.key,
    required this.children,
    this.selectedIndex,
    this.onDestinationSelected,
  });

  final List<Widget> children;
  final int? selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return NavigationDrawerTheme(
      data: NavigationDrawerThemeData(
        backgroundColor: theme.colorScheme.surface,
        indicatorColor: fpduiTheme.accent,
        surfaceTintColor: Colors.transparent,
        iconTheme: WidgetStateProperty.resolveWith((states) {
           if (states.contains(WidgetState.selected)) {
              return IconThemeData(color: fpduiTheme.accentForeground);
           }
           return IconThemeData(color: theme.colorScheme.onSurface.withValues(alpha: 0.7));
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
           if (states.contains(WidgetState.selected)) {
              return theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              );
           }
           return theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
           );
        }),
      ),
      child: NavigationDrawer(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        backgroundColor: theme.colorScheme.surface, // Redundant but safe
        elevation: 0,
        tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        children: children,
      ),
    );
  }
}
