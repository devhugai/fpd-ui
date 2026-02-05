/// Responsible for side drawer navigation.
/// Provides FpduiNavigationDrawer.
///
/// Used by: Scaffolds (drawer).
/// Depends on: fpdui_theme.
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
        backgroundColor: theme.colorScheme.background,
        indicatorColor: fpduiTheme.accent,
        surfaceTintColor: Colors.transparent,
        iconTheme: MaterialStateProperty.resolveWith((states) {
           if (states.contains(MaterialState.selected)) {
              return IconThemeData(color: fpduiTheme.accentForeground);
           }
           return IconThemeData(color: theme.colorScheme.onBackground.withOpacity(0.7));
        }),
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
           if (states.contains(MaterialState.selected)) {
              return theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onBackground,
                fontWeight: FontWeight.w600,
              );
           }
           return theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onBackground.withOpacity(0.7),
           );
        }),
      ),
      child: NavigationDrawer(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        children: children,
        backgroundColor: theme.colorScheme.background, // Redundant but safe
        elevation: 0,

        tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      ),
    );
  }
}
