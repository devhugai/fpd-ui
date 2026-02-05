/// Responsible for display persistent bottom navigation.
/// Provides FpduiNavigationBar.
///
/// Used by: Scaffolds (bottomNavigationBar).
/// Depends on: fpdui_theme.
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
        backgroundColor: theme.colorScheme.background,
        indicatorColor: fpduiTheme.accent, // Selected background
        surfaceTintColor: Colors.transparent,
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
           if (states.contains(MaterialState.selected)) {
             return theme.textTheme.labelSmall?.copyWith(
               color: theme.colorScheme.onBackground,
               fontWeight: FontWeight.w600,
             );
           }
           return theme.textTheme.labelSmall?.copyWith(
             color: theme.colorScheme.onBackground.withOpacity(0.7),
           );
        }),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return IconThemeData(color: fpduiTheme.accentForeground);
          }
           return IconThemeData(color: theme.colorScheme.onBackground.withOpacity(0.7));
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
