/// Responsible for loading state placeholders.
/// Provides FpduiSkeleton widget.
///
/// Used by: Loading screens, async data fetching.
/// Depends on: shimmer/animate effects, fpdui_theme.
/// Assumes: Mimics shape of content being loaded.
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/fpdui_theme.dart';

class FpduiSkeleton extends StatelessWidget {
  const FpduiSkeleton({
    super.key,
    this.width,
    this.height,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
  });

  final double? width;
  final double? height;
  final BoxShape shape;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Animate(
      onPlay: (controller) => controller.repeat(reverse: true),
      effects: [
         FadeEffect(
          duration: 1000.ms,
          curve: Curves.easeInOut,
          begin: 0.5,
          end: 1.0,
        ),
      ],
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: fpduiTheme.muted, // bg-muted
          shape: shape,
          borderRadius: shape == BoxShape.rectangle 
              ? (borderRadius ?? BorderRadius.circular(fpduiTheme.radius))
              : null,
        ),
      ),
    );
  }
}
