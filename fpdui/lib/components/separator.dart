// Responsible for visual separation of content.
// Provides FpduiSeparator (divider).
//
// Used by: Lists, layouts.
// Depends on: fpdui_theme.
// Assumes: Horizontal or vertical orientation.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiSeparator extends StatelessWidget {
  const FpduiSeparator({
    super.key,
    this.orientation = Axis.horizontal,
    this.color,
  });

  final Axis orientation;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    final effectiveColor = color ?? fpduiTheme.border;

    if (orientation == Axis.horizontal) {
      return Divider(
        height: 1,
        thickness: 1,
        color: effectiveColor,
      );
    } else {
      return VerticalDivider(
        width: 1,
        thickness: 1,
        color: effectiveColor,
      );
    }
  }
}
