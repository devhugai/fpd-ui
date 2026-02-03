import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

enum FpduiBadgeVariant {
  primary,
  secondary,
  destructive,
  outline,
}

class FpduiBadge extends StatelessWidget {
  const FpduiBadge({
    super.key,
    this.variant = FpduiBadgeVariant.primary,
    required this.child,
    this.text,
  });

  final FpduiBadgeVariant variant;
  final Widget child;
  final String? text;

  factory FpduiBadge.text(String text, {
    Key? key,
    FpduiBadgeVariant variant = FpduiBadgeVariant.primary,
  }) {
    return FpduiBadge(
      key: key,
      variant: variant,
      text: text,
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    Color? backgroundColor;
    Color? foregroundColor;
    Color? borderColor;

    switch (variant) {
      case FpduiBadgeVariant.primary:
        backgroundColor = fpduiTheme.primary;
        foregroundColor = fpduiTheme.primaryForeground;
        break;
      case FpduiBadgeVariant.secondary:
        backgroundColor = fpduiTheme.secondary;
        foregroundColor = fpduiTheme.secondaryForeground;
        break;
      case FpduiBadgeVariant.destructive:
        backgroundColor = fpduiTheme.destructive;
        foregroundColor = fpduiTheme.destructiveForeground;
        break;
      case FpduiBadgeVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colorScheme.onBackground;
        borderColor = fpduiTheme.border;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2), // px-2.5 py-0.5
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100), // rounded-full
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: foregroundColor,
          fontSize: 12, // text-xs
          fontWeight: FontWeight.w600, // font-semibold
        ),
        child: child,
      ),
    );
  }
}
