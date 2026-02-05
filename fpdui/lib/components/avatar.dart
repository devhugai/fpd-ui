// Responsible for displaying user profile images or fallbacks.
// Provides FpduiAvatar widget with circle clipping.
//
// Used by: User profiles, lists, headers.
// Depends on: fpdui_theme.
// Assumes: ImageProvider can fail, handles error with fallback.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

enum FpduiAvatarSize {
  sm,
  $default,
  lg,
}

class FpduiAvatar extends StatelessWidget {
  const FpduiAvatar({
    super.key,
    this.image,
    this.fallback,
    this.size = FpduiAvatarSize.$default,
    this.backgroundColor,
    this.foregroundColor,
  });

  final ImageProvider? image;
  final Widget? fallback;
  final FpduiAvatarSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    double dimension;
    double fontSize;

    switch (size) {
      case FpduiAvatarSize.sm:
        dimension = 24.0; // size-6
        fontSize = 10.0;
        break;
      case FpduiAvatarSize.$default:
        dimension = 32.0; // size-8
        fontSize = 14.0;
        break;
      case FpduiAvatarSize.lg:
        dimension = 40.0; // size-10
        fontSize = 16.0;
        break;
    }

    final bgColor = backgroundColor ?? fpduiTheme.muted;
    final fgColor = foregroundColor ?? fpduiTheme.mutedForeground;

    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      color: fgColor,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    ) ?? TextStyle(
      color: fgColor,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    );

    return SizedBox(
      width: dimension,
      height: dimension,
      child: CircleAvatar(
        radius: dimension / 2,
        backgroundColor: bgColor,
        foregroundImage: image,
        // When foregroundImage fails or is null, child is shown.
        // We use child for fallback.
        child: fallback != null 
            ? DefaultTextStyle(
                style: textStyle,
                child: fallback!,
              )
            : null,
      ),
    );
  }
}
