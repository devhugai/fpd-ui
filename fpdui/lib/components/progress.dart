/// Responsible for indicating loading or progress state.
/// Provides FpduiProgress indicator.
///
/// Used by: Uploads, loading screens.
/// Depends on: fpdui_theme.
/// Assumes: 0.0 to 1.0 (or 100) range value.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

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
    
    // Validate bounds
    final safeValue = value.clamp(0.0, max);
    final percentage = safeValue / max;

    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.2), // bg-primary/20
        borderRadius: BorderRadius.circular(100), // rounded-full
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic, // Smooth deceleration
                width: constraints.maxWidth * percentage,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary, // bg-primary
                  borderRadius: BorderRadius.circular(100), // rounded-full (inner)
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
