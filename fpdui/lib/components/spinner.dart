/// Responsible for indicating indeterminate loading state.
/// Provides FpduiSpinner widget.
///
/// Used by: Loading states.
/// Depends on: fpdui_theme.
/// Assumes: Circular style.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiSpinner extends StatelessWidget {
  const FpduiSpinner({
    super.key,
    this.size = 24.0,
    this.color,
  });

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Use primary color or provided color
    final spinnerColor = color ?? theme.colorScheme.primary;

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(spinnerColor),
      ),
    );
  }
}
