// Responsible for displaying transient notifications.
// Provides FpduiToast, ToastProvider, useToast hook.
//
// Used by: Global app notifications.
// Depends on: fpdui_theme, flutter_animate.
// Assumes: Toaster widget wraps the app.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';

class FpduiToast {
  static void show(
    BuildContext context, 
    String title, {
    String? description,
    FpduiToastVariant variant = FpduiToastVariant.defaultVariant,
    Duration duration = const Duration(seconds: 4),
    Widget? action,
  }) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    Color bgColor = theme.colorScheme.surface;
    Color textColor = theme.colorScheme.onSurface;
    Color borderColor = fpduiTheme.border;
    IconData? icon;
    Color iconColor = textColor;

    switch (variant) {
      case FpduiToastVariant.destructive:
        bgColor = theme.colorScheme.error;
        textColor = theme.colorScheme.onError;
        borderColor = theme.colorScheme.error;
        icon = LucideIcons.alertOctagon;
        iconColor = textColor;
        break;
      case FpduiToastVariant.success:
        bgColor = fpduiTheme.success;
        textColor = fpduiTheme.successForeground;
        borderColor = fpduiTheme.success;
        icon = LucideIcons.checkCircle;
        iconColor = fpduiTheme.successForeground;
        break;
      case FpduiToastVariant.warning:
        bgColor = fpduiTheme.warning;
        textColor = fpduiTheme.warningForeground;
        borderColor = fpduiTheme.warning;
        icon = LucideIcons.alertTriangle;
        iconColor = fpduiTheme.warningForeground;
        break;
      case FpduiToastVariant.info:
        bgColor = fpduiTheme.info;
        textColor = fpduiTheme.infoForeground;
        borderColor = fpduiTheme.info;
        icon = LucideIcons.info;
        iconColor = fpduiTheme.infoForeground;
        break;
      default:
        bgColor = fpduiTheme.popover; // Default background
        break;
    }
    
    // SnackBar already provides safe area and positioning. 
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: Colors.transparent, // We wrap content
        elevation: 0,
        behavior: SnackBarBehavior.floating, // Mimic floating toast
        padding: EdgeInsets.zero, // Custom padding in container
        // Provide a dismissible/styled container
        content: Container(
          // width: 356, // Let it be flexible
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(fpduiTheme.radius),
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: fpduiTheme.shadow,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: iconColor),
                const Gap(12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    if (description != null) ...[
                      const Gap(4),
                      Text(
                        description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: textColor.withValues(alpha: 0.8), // Will fix deprecation in verification step
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (action != null) ...[
                const Gap(12),
                action,
              ],
              const Gap(12),
              GestureDetector(
                onTap: () {
                   ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                child: Icon(LucideIcons.x, size: 16, color: textColor.withValues(alpha: 0.5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum FpduiToastVariant { defaultVariant, destructive, success, warning, info }

/// Deprecated: Toaster is managed by ScaffoldMessenger now.
/// Kept as stub if needed to prevent immediate crashes during refactor, but standard is to remove.
/// We'll remove it.

