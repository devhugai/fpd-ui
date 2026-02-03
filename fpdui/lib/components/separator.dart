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
      return Container(
        height: 1,
        width: double.infinity,
        color: effectiveColor,
      );
    } else {
      return Container(
        width: 1,
        height: double.infinity,
        color: effectiveColor,
      );
    }
  }
}
