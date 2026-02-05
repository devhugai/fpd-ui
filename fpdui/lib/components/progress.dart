// Responsible for indicating loading or progress state.
// Provides FpduiProgress indicator.
//
// Used by: Uploads, loading screens.
// Depends on: fpdui_theme.
// Assumes: 0.0 to 1.0 (or 100) range value.
import 'package:flutter/material.dart';


class FpduiProgress extends StatelessWidget {
  const FpduiProgress({
    super.key,
    required this.value,
    this.max = 100,
    this.height = 8.0, // h-2 -> 8px
  });

  /// The current value of the progress bar.
  final double value;
  
  /// The maximum value (default 100).
  final double max;
  
  /// Height of the progress bar.
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final fpduiTheme = theme.extension<FpduiTheme>()!;
    
    // Validate bounds
    final safeValue = value.clamp(0.0, max);
    final percentage = max == 0 ? 0.0 : safeValue / max;

    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100), // rounded-full
        child: LinearProgressIndicator(
          value: percentage,
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.2), // bg-primary/20
          valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary), // bg-primary
        ),
      ),
    );
  }
}
