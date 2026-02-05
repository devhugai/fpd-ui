// Responsible for side navigation.
// Provides FpduiNavigationRail.
//
// Used by: Scaffolds on larger screens.
// Depends on: fpdui_theme.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiNavigationRail extends StatelessWidget {
  const FpduiNavigationRail({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    this.onDestinationSelected,
    this.extended = false,
    this.leading,
    this.trailing,
  });

  final List<NavigationRailDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  final bool extended;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return NavigationRailTheme(
      data: NavigationRailThemeData(
        backgroundColor: theme.colorScheme.surface,
        indicatorColor: fpduiTheme.accent,
        selectedIconTheme: IconThemeData(color: fpduiTheme.accentForeground),
        unselectedIconTheme: IconThemeData(color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
        selectedLabelTextStyle: TextStyle(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          fontSize: 12,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(right: BorderSide(color: fpduiTheme.border)),
        ),
        child: NavigationRail(
          destinations: destinations,
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          extended: extended,
          leading: leading,
          trailing: trailing,
          backgroundColor: Colors.transparent, // Handled by container/theme
        ),
      ),
    );
  }
}
