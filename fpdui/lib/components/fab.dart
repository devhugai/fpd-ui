/// Responsible for primary screen actions.
/// Provides FpduiFAB widget.
///
/// Used by: Scaffold floatingActionButton.
/// Depends on: fpdui_theme.
/// Assumes: Floating positioning.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

enum FpduiFABVariant {
  primary,
  secondary,
  outline,
  ghost, 
  destructive,
}

enum FpduiFABSize {
  defaultSize,
  sm,
  lg,
}

class FpduiFAB extends StatelessWidget {
  const FpduiFAB({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = FpduiFABVariant.primary,
    this.size = FpduiFABSize.defaultSize,
    this.tooltip,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final FpduiFABVariant variant;
  final FpduiFABSize size;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    Color? backgroundColor;
    Color foregroundColor;
    Border? border;
    double elevation = 2;

    switch (variant) {
      case FpduiFABVariant.secondary:
        backgroundColor = fpduiTheme.secondary;
        foregroundColor = fpduiTheme.secondaryForeground;
        break;
      case FpduiFABVariant.destructive:
        backgroundColor = fpduiTheme.destructive;
        foregroundColor = fpduiTheme.destructiveForeground;
        break;
      case FpduiFABVariant.outline:
        backgroundColor = theme.colorScheme.background;
        foregroundColor = theme.colorScheme.onBackground;
        border = Border.all(color: fpduiTheme.input);
        elevation = 0;
        break;
      case FpduiFABVariant.ghost:
         backgroundColor = Colors.transparent;
         foregroundColor = theme.colorScheme.onBackground;
         elevation = 0;
         break;
      case FpduiFABVariant.primary:
      default:
        backgroundColor = fpduiTheme.primary;
        foregroundColor = fpduiTheme.primaryForeground;
        break;
    }

    double dimension;
    double iconSize;

    switch (size) {
      case FpduiFABSize.sm:
        dimension = 40;
        iconSize = 20;
        break;
      case FpduiFABSize.lg:
        dimension = 64;
        iconSize = 28;
        break;
      case FpduiFABSize.defaultSize:
      default:
        dimension = 56;
        iconSize = 24;
        break;
    }

    Widget button = Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(
        color: backgroundColor,
        // borderRadius: BorderRadius.circular(dimension / 2), // Removed circular
        borderRadius: BorderRadius.circular(fpduiTheme.radiusLg), 
        border: border,
        boxShadow: elevation > 0 ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4 * elevation,
            offset: Offset(0, 2 * elevation),
          )
        ] : null,
      ),
      alignment: Alignment.center,
      child: IconTheme(
        data: IconThemeData(size: iconSize, color: foregroundColor),
        child: child,
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip, child: button);
    }

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(fpduiTheme.radiusLg),
        child: button,
      ),
    );
  }
}
