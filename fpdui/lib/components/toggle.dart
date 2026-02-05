/// Responsible for a two-state button.
/// Provides FpduiToggle widget.
///
/// Used by: Text editors (Bold, Italic), settings.
/// Depends on: fpdui_theme, button.dart (conceptually).
/// Assumes: Controlled component.
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

    Color? backgroundColor;
    Color foregroundColor;
    Border? border;

    // Resolve styles based on variant and state
    if (variant == FpduiToggleVariant.outline) {
      if (isPressed) {
        backgroundColor = fpduiTheme.accent;
        foregroundColor = fpduiTheme.accentForeground;
        border = Border.all(color: fpduiTheme.input);
      } else {
        backgroundColor = Colors.transparent;
        foregroundColor = fpduiTheme.mutedForeground;
        border = Border.all(color: fpduiTheme.input);
      }
    } else {
      // Default
      if (isPressed) {
        backgroundColor = fpduiTheme.accent;
        foregroundColor = fpduiTheme.accentForeground;
      } else {
        backgroundColor = Colors.transparent;
        foregroundColor = fpduiTheme.mutedForeground;
      }
    }

    EdgeInsets padding;
    double height;
    
    switch (size) {
      case FpduiToggleSize.sm:
        height = 36;
        padding = const EdgeInsets.symmetric(horizontal: 10);
        break;
      case FpduiToggleSize.lg:
        height = 44;
        padding = const EdgeInsets.symmetric(horizontal: 20);
        break;
      case FpduiToggleSize.defaultSize:
      default:
        height = 40;
        padding = const EdgeInsets.symmetric(horizontal: 12);
        break;
    }

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(fpduiTheme.radius),
      child: Container(
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(fpduiTheme.radius),
          border: border,
        ),
        child: Center(
          widthFactor: 1.0, 
          child: DefaultTextStyle(
            style: TextStyle(
              color: foregroundColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            child: IconTheme(
              data: IconThemeData(
                color: foregroundColor,
                size: 20, // slightly larger for icons usually
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
