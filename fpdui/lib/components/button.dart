/// Responsible for providing standard interactive buttons.
/// Provides FpduiButton with standard variants (primary, secondary, ghost, etc).
///
/// Used by: Forms, Actions, Dialogs.
/// Depends on: fpdui_theme.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../theme/fpdui_theme.dart';

enum FpduiButtonVariant {
  primary,
  destructive,
  outline,
  secondary,
  ghost,
  link,
}

enum FpduiButtonSize {
  $default,
  sm,
  lg,
  icon,
}

class FpduiButton extends StatelessWidget {
  const FpduiButton({
    super.key,
    this.variant = FpduiButtonVariant.primary,
    this.size = FpduiButtonSize.$default,
    this.onPressed,
    this.child,
    this.text,
    this.icon,
    this.trailingIcon,
    this.width,
    this.height,
  }) : assert(child != null || text != null, 'Either child or text must be provided');

  final FpduiButtonVariant variant;
  final FpduiButtonSize size;
  final VoidCallback? onPressed;
  final Widget? child;
  final String? text;
  final Widget? icon;
  final Widget? trailingIcon;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    // 1. Resolve Dimensions (Height & Padding)
    double? defaultHeight;
    EdgeInsetsGeometry defaultPadding;
    double? minWidth;

    switch (size) {
      case FpduiButtonSize.sm:
        defaultHeight = 36; // h-9
        defaultPadding = const EdgeInsets.symmetric(horizontal: 12); // px-3
        break;
      case FpduiButtonSize.lg:
        defaultHeight = 44; // h-11
        defaultPadding = const EdgeInsets.symmetric(horizontal: 32); // px-8
        break;
      case FpduiButtonSize.icon:
        defaultHeight = 40; // h-10
        defaultPadding = EdgeInsets.zero;
        minWidth = 40; // w-10
        break;
      case FpduiButtonSize.$default:
      default:
        defaultHeight = 40; // h-10
        defaultPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8); // px-4 py-2
        break;
    }

    final effectiveHeight = height ?? defaultHeight;
    final effectivePadding = size == FpduiButtonSize.icon ? EdgeInsets.zero : defaultPadding;
    // For FixedSize/Width, we might use minimumSize in style

    // 2. Build Content
    Widget effectiveChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          IconTheme(
            data: IconThemeData(size: 16, color: _getIconColor(variant, fpduiTheme, theme)),
            child: icon!,
          ),
          if (text != null || child != null) const Gap(8),
        ],
        if (text != null)
          Text(text!)
        else
          child!,
        if (trailingIcon != null) ...[
          const Gap(8),
          IconTheme(
            data: IconThemeData(size: 16, color: _getIconColor(variant, fpduiTheme, theme)),
            child: trailingIcon!,
          ),
        ],
      ],
    );

    // 3. Select Native Implementation
    // Common style properties
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(fpduiTheme.radius),
    );
    
    final textStyle = theme.textTheme.labelMedium?.copyWith( // text-sm
      fontWeight: FontWeight.w500, // font-medium
    );

    switch (variant) {
      case FpduiButtonVariant.primary:
        return SizedBox(
          width: width ?? (size == FpduiButtonSize.icon ? effectiveHeight : null),
          height: effectiveHeight,
          child: FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: fpduiTheme.primary,
              foregroundColor: fpduiTheme.primaryForeground,
              shape: shape,
              padding: effectivePadding,
              textStyle: textStyle,
              minimumSize: Size(minWidth ?? 0, effectiveHeight),
              elevation: 0,
            ),
            child: effectiveChild,
          ),
        );

      case FpduiButtonVariant.secondary:
        return SizedBox(
           width: width ?? (size == FpduiButtonSize.icon ? effectiveHeight : null),
           height: effectiveHeight,
           child: FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: fpduiTheme.secondary,
              foregroundColor: fpduiTheme.secondaryForeground,
              shape: shape,
              padding: effectivePadding,
              textStyle: textStyle,
              minimumSize: Size(minWidth ?? 0, effectiveHeight),
              elevation: 0,
            ).copyWith(
              overlayColor: WidgetStateProperty.all(fpduiTheme.secondaryForeground.withOpacity(0.1)),
            ),
            child: effectiveChild,
          ),
        );

      case FpduiButtonVariant.destructive:
        return SizedBox(
           width: width ?? (size == FpduiButtonSize.icon ? effectiveHeight : null),
           height: effectiveHeight,
           child: FilledButton(
             onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: fpduiTheme.destructive,
              foregroundColor: fpduiTheme.destructiveForeground,
              shape: shape,
              padding: effectivePadding,
              textStyle: textStyle,
              minimumSize: Size(minWidth ?? 0, effectiveHeight),
              elevation: 0,
            ),
            child: effectiveChild,
          ),
        );

      case FpduiButtonVariant.outline:
        return SizedBox(
           width: width ?? (size == FpduiButtonSize.icon ? effectiveHeight : null),
           height: effectiveHeight,
           child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              backgroundColor: theme.colorScheme.surface,
              foregroundColor: theme.colorScheme.onSurface,
              side: BorderSide(color: fpduiTheme.input), // border-input
              shape: shape,
              padding: effectivePadding,
              textStyle: textStyle,
              minimumSize: Size(minWidth ?? 0, effectiveHeight),
              elevation: 0,
            ).copyWith(
              overlayColor: WidgetStateProperty.all(fpduiTheme.accent.withOpacity(0.5)),
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.hovered)) {
                  return fpduiTheme.accent;
                }
                return theme.colorScheme.surface;
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.hovered)) {
                  return fpduiTheme.accentForeground;
                }
                return theme.colorScheme.onSurface;
              }),
            ),
            child: effectiveChild,
          ),
        );

      case FpduiButtonVariant.ghost:
        return SizedBox(
           width: width ?? (size == FpduiButtonSize.icon ? effectiveHeight : null),
           height: effectiveHeight,
           child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.onSurface,
              shape: shape,
              padding: effectivePadding,
              textStyle: textStyle,
              minimumSize: Size(minWidth ?? 0, effectiveHeight),
            ).copyWith(
              overlayColor: WidgetStateProperty.all(Colors.transparent), // We handle hover bg
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                 if (states.contains(WidgetState.hovered)) {
                   return fpduiTheme.accent;
                 }
                 return Colors.transparent;
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                 if (states.contains(WidgetState.hovered)) {
                   return fpduiTheme.accentForeground;
                 }
                 return theme.colorScheme.onSurface;
              }),
            ),
            child: effectiveChild,
          ),
        );

      case FpduiButtonVariant.link:
        return SizedBox(
           width: width ?? (size == FpduiButtonSize.icon ? effectiveHeight : null),
           height: effectiveHeight,
           child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor: fpduiTheme.primary,
              shape: shape,
              padding: effectivePadding,
              textStyle: textStyle?.copyWith(decoration: TextDecoration.underline), 
              // Shadcn link is underline on hover usually, but material text button generic.
              // Let's stick to standard TextButton logic but ensure spacing.
              minimumSize: Size(minWidth ?? 0, effectiveHeight),
            ).copyWith(
               overlayColor: WidgetStateProperty.all(Colors.transparent),
               // Link variant usually doesn't have background hover
            ),
            child: effectiveChild,
          ),
        );
    }
  }

  Color? _getIconColor(FpduiButtonVariant variant, FpduiTheme fpdui, ThemeData theme) {
    // This is optional since usually icon inherits context color, but explicit for safety
    switch (variant) {
      case FpduiButtonVariant.primary: return fpdui.primaryForeground;
      case FpduiButtonVariant.destructive: return fpdui.destructiveForeground;
      case FpduiButtonVariant.secondary: return fpdui.secondaryForeground;
      case FpduiButtonVariant.outline: // interactive color depends on hover, assume null to inherit from button
      case FpduiButtonVariant.ghost: 
      case FpduiButtonVariant.link:
      return null; // Inherit
    }
  }
}


