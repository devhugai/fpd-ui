// Responsible for a two-state button.
// Provides FpduiToggle widget.
//
// Used by: Text editors (Bold, Italic), settings.
// Depends on: fpdui_theme, button.dart (conceptually).
// Assumes: Controlled component.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

enum FpduiToggleVariant {
  defaultVariant,
  outline,
}

enum FpduiToggleSize {
  defaultSize,
  sm,
  lg,
}

class FpduiToggle extends StatelessWidget {
  const FpduiToggle({
    super.key,
    required this.isPressed,
    required this.onPressed,
    required this.child,
    this.variant = FpduiToggleVariant.defaultVariant,
    this.size = FpduiToggleSize.defaultSize,
  });

  final bool isPressed;
  final VoidCallback? onPressed;
  final Widget child;
  final FpduiToggleVariant variant;
  final FpduiToggleSize size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    double iconSize;
    EdgeInsetsGeometry padding;
    BoxConstraints constraints;

    switch (size) {
      case FpduiToggleSize.sm:
        iconSize = 16;
        padding = const EdgeInsets.all(8); // minimal padding for sm
        constraints = const BoxConstraints(minWidth: 36, minHeight: 36);
        break;
      case FpduiToggleSize.lg:
        iconSize = 24;
        padding = const EdgeInsets.all(12);
        constraints = const BoxConstraints(minWidth: 44, minHeight: 44);
        break;
      case FpduiToggleSize.defaultSize:
        iconSize = 20;
        padding = const EdgeInsets.all(10);
        constraints = const BoxConstraints(minWidth: 40, minHeight: 40);
        break;
    }

    // Determine colors based on state
    Color? backgroundColor;
    Color foregroundColor;
    BorderSide? side;

    if (variant == FpduiToggleVariant.outline) {
      side = BorderSide(color: fpduiTheme.input);
      if (isPressed) {
        backgroundColor = fpduiTheme.accent;
        foregroundColor = fpduiTheme.accentForeground;
      } else {
        backgroundColor = Colors.transparent;
        foregroundColor = fpduiTheme.mutedForeground;
      }
    } else {
      if (isPressed) {
        backgroundColor = fpduiTheme.accent;
        foregroundColor = fpduiTheme.accentForeground;
      } else {
        backgroundColor = Colors.transparent;
        foregroundColor = fpduiTheme.mutedForeground;
      }
    }

    return IconButton(
      onPressed: onPressed,
      isSelected: isPressed,
      icon: child,
      iconSize: iconSize,
      padding: padding,
      constraints: constraints,
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        hoverColor: fpduiTheme.muted.withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(fpduiTheme.radius),
           side: side ?? BorderSide.none,
        ),
      ),
    );
  }
}
