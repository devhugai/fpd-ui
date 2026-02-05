/// Responsible for displaying user profile images or fallbacks.
/// Provides FpduiAvatar widget with circle clipping.
///
/// Used by: User profiles, lists, headers.
/// Depends on: fpdui_theme.
/// Assumes: ImageProvider can fail, handles error with fallback.
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

    return Container(
      width: dimension,
      height: dimension,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: image != null
          ? Image(
              image: image!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _buildFallback(textStyle),
            )
          : _buildFallback(textStyle),
    );
  }

  Widget _buildFallback(TextStyle textStyle) {
    if (fallback == null) return const SizedBox();
    return Center(
      child: DefaultTextStyle(
        style: textStyle,
        child: fallback!,
      ),
    );
  }
}
