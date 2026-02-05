/// Responsible for displaying status indicators or small counts.
/// Provides FpduiBadge widget.
///
/// Used by: Notifications, status labels.
/// Depends on: fpdui_theme.
/// Assumes: Short text content.
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
    Color? labelColor;
    BorderSide? side;

    switch (variant) {
      case FpduiBadgeVariant.primary:
        backgroundColor = fpduiTheme.primary;
        labelColor = fpduiTheme.primaryForeground;
        break;
      case FpduiBadgeVariant.secondary:
        backgroundColor = fpduiTheme.secondary;
        labelColor = fpduiTheme.secondaryForeground;
        break;
      case FpduiBadgeVariant.destructive:
        backgroundColor = fpduiTheme.destructive;
        labelColor = fpduiTheme.destructiveForeground;
        break;
      case FpduiBadgeVariant.outline:
        backgroundColor = Colors.transparent;
        labelColor = theme.colorScheme.onSurface;
        side = BorderSide(color: fpduiTheme.border);
        break;
    }

    return RawChip(
      label: DefaultTextStyle(
        style: theme.textTheme.labelSmall?.copyWith(
              color: labelColor,
              fontSize: 12, // text-xs
              fontWeight: FontWeight.w600, // font-semibold
            ) ??
            const TextStyle(),
        child: child,
      ),
      backgroundColor: backgroundColor,
      side: side ?? BorderSide.none,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)), // rounded-full
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2), // px-2.5 py-0.5
      // RawChip defaults add some padding/margins we might want to strip to match "Badge" look
      labelPadding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      isEnabled: false, // Badges are typically static indicators
      disabledColor: backgroundColor, // Maintain color when disabled
    );
  }
}
