// Responsible for primary screen actions.
// Provides FpduiFAB widget.
//
// Used by: Scaffold floatingActionButton.
// Depends on: fpdui_theme.
// Assumes: Floating positioning.
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
    double? elevation = 6;
    ShapeBorder? shape;


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
        backgroundColor = theme.colorScheme.surface;
        foregroundColor = theme.colorScheme.onSurface;
        elevation = 0;
        shape = CircleBorder(side: BorderSide(color: fpduiTheme.input)); 
        // Or RoundedRectangle depending on FAB shape preference. FAB is usually circular or squircle.
        // FPD UI seems to use rounded-lg for FAB?
        break;
      case FpduiFABVariant.ghost:
         backgroundColor = Colors.transparent;
         foregroundColor = theme.colorScheme.onSurface;
         elevation = 0;
         break;
      case FpduiFABVariant.primary:
        backgroundColor = fpduiTheme.primary;
        foregroundColor = fpduiTheme.primaryForeground;
        break;
    }

    // Resolve shape - FPD Theme FAB is typically rounded-lg? No, FABs are usually rounded-xl or full.
    // Original implementation: `borderRadius: BorderRadius.circular(fpduiTheme.radiusLg)`
    shape ??= RoundedRectangleBorder(borderRadius: BorderRadius.circular(fpduiTheme.radiusLg));

    double dimension;

    switch (size) {
      case FpduiFABSize.sm:
        dimension = 40; // mini
        break;
      case FpduiFABSize.lg:
        dimension = 64; // large
        break;
      case FpduiFABSize.defaultSize:
        dimension = 56; // default
        break;
    }

    // Native FAB has `mini` property which toggles between 40 and 56.
    // For `lg` (64), we might need `Custom` constraints, but standard FAB is usually strict on Material specs.
    // However, `SizedBox` wrapper works.

    return SizedBox(
      width: dimension,
      height: dimension,
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: elevation,
        focusElevation: elevation,
        hoverElevation: elevation,
        disabledElevation: 0,
        highlightElevation: elevation, // Keep flat look often desired in modern UI, or allow slight lift
        tooltip: tooltip,
        shape: shape,
        // mini: size == FpduiFABSize.sm, // Controlled by SizedBox, but mini changes internal padding too.
        // If we use SizedBox, we should probably let FAB expand.
        child: child,
      ),
    );
  }
}


