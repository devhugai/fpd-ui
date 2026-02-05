// Responsible for showing snackbars via ScaffoldMessenger.
// Provides FpduiSnackbar utility.
//
// Used by: Material Scaffold integration.
// Depends on: fpdui_theme.
// Assumes: Scaffold context available.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

enum FpduiSnackbarVariant {
  defaultVariant,
  destructive,
  success,
}

class FpduiSnackbar {
  static void show(
    BuildContext context, {
    required String title,
    String? description,
    FpduiSnackbarVariant variant = FpduiSnackbarVariant.defaultVariant,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    Color bgColor;
    Color fgColor;
    Color actionColor;

    switch (variant) {
      case FpduiSnackbarVariant.destructive:
        bgColor = fpduiTheme.destructive;
        fgColor = fpduiTheme.destructiveForeground;
        actionColor = fpduiTheme.destructiveForeground;
        break;
      case FpduiSnackbarVariant.success:
        bgColor = fpduiTheme.success;
        fgColor = fpduiTheme.successForeground;
        actionColor = fpduiTheme.successForeground;
        break;
      case FpduiSnackbarVariant.defaultVariant:
        // Inverse colors usually for snackbars to stand out
        bgColor = theme.colorScheme.onSurface;
        fgColor = theme.colorScheme.surface;
        actionColor = fpduiTheme.primary;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          description != null ? '$title\n$description' : title,
           style: theme.textTheme.bodyMedium?.copyWith(
            color: fgColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(fpduiTheme.radius),
        ),
        margin: const EdgeInsets.all(16), 
        // If floating, margin applies.
        
        duration: duration,
        action: actionLabel != null && onAction != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: actionColor,
                onPressed: onAction,
              )
            : null,
      ),
    );
  }
}
