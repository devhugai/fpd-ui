// Responsible for display persistent bottom navigation.
// Provides FpduiNavigationBar.
//
// Used by: Scaffolds (bottomNavigationBar).
// Depends on: fpdui_theme.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiNavigationBar extends StatelessWidget {
  const FpduiNavigationBar({
    super.key,
    required this.destinations,
    this.selectedIndex = 0,
    this.onDestinationSelected,
    this.labelBehavior,
  });

  final List<Widget> destinations;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  final NavigationDestinationLabelBehavior? labelBehavior;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return NavigationBarTheme(
      data: NavigationBarThemeData(
        backgroundColor: theme.colorScheme.surface,
        indicatorColor: fpduiTheme.accent, // Selected background
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
           if (states.contains(WidgetState.selected)) {
             return theme.textTheme.labelSmall?.copyWith(
               color: theme.colorScheme.onSurface,
               fontWeight: FontWeight.w600,
             );
           }
           return theme.textTheme.labelSmall?.copyWith(
             color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
           );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: fpduiTheme.accentForeground);
          }
           return IconThemeData(color: theme.colorScheme.onSurface.withValues(alpha: 0.7));
        }),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: fpduiTheme.border)),
        ),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          labelBehavior: labelBehavior,
          destinations: destinations,
          elevation: 0,
          backgroundColor: Colors.transparent, // Handled by container/theme
        ),
      ),
    );
  }
}
