// Responsible for static or dismissible feedback boxes.
// Provides FpduiAlert, AlertTitle, and AlertDescription widgets.
//
// Used by: Forms, content areas for warnings/info.
// Depends on: fpdui_theme, lucide_icons.
// Assumes: Inline display (not modal).
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';

enum FpduiAlertVariant {
  defaultVariant,
  destructive,
  warning,
  success,
}

class FpduiAlert extends StatelessWidget {
  const FpduiAlert({
    super.key,
    required this.child,
    this.icon,
    this.variant = FpduiAlertVariant.defaultVariant,
  });

  final Widget child;
  final IconData? icon;
  final FpduiAlertVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    Color borderColor;
    Color iconColor;
    Color textColor;
    Color backgroundColor; // Optional background tint

    switch (variant) {
      case FpduiAlertVariant.destructive:
        borderColor = fpduiTheme.destructive.withValues(alpha: 0.5);
        iconColor = fpduiTheme.destructive;
        textColor = fpduiTheme.destructive;
        backgroundColor = fpduiTheme.destructive.withValues(alpha: 0.05); // Subtle tint
        break;
      case FpduiAlertVariant.warning:
        borderColor = fpduiTheme.warning.withValues(alpha: 0.5);
        iconColor = fpduiTheme.warning;
        textColor = fpduiTheme.warning;
        backgroundColor = fpduiTheme.warning.withValues(alpha: 0.05);
        break;
      case FpduiAlertVariant.success:
        borderColor = fpduiTheme.success.withValues(alpha: 0.5);
        iconColor = fpduiTheme.success;
        textColor = fpduiTheme.success;
        backgroundColor = fpduiTheme.success.withValues(alpha: 0.05);
        break;
      case FpduiAlertVariant.defaultVariant:
      default:
        borderColor = fpduiTheme.border;
        iconColor = theme.colorScheme.onSurface;
        textColor = theme.colorScheme.onSurface;
        backgroundColor = theme.colorScheme.surface;
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(fpduiTheme.radiusLg),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: iconColor),
            const Gap(12),
          ],
          Expanded(
            child: DefaultTextStyle(
              style: theme.textTheme.bodyMedium!.copyWith(color: textColor),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class FpduiAlertTitle extends StatelessWidget {
  const FpduiAlertTitle(this.data, {super.key});

  final String data;

  @override
  Widget build(BuildContext context) {
    // Inherit color from parent DefaultTextStyle, just adjust weight
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        data,
        style: const TextStyle(fontWeight: FontWeight.w600, height: 1.0),
      ),
    );
  }
}

class FpduiAlertDescription extends StatelessWidget {
  const FpduiAlertDescription(this.data, {super.key});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: const TextStyle(fontWeight: FontWeight.w400, height: 1.5),
    );
  }
}
