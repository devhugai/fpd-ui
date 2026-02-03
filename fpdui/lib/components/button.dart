import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

class FpduiButton extends StatefulWidget {
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
  State<FpduiButton> createState() => _FpduiButtonState();
}

class _FpduiButtonState extends State<FpduiButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    
    // Determine colors based on variant
    Color? backgroundColor;
    Color? foregroundColor;
    Color? borderColor;
    
    switch (widget.variant) {
      case FpduiButtonVariant.primary:
        backgroundColor = fpduiTheme.primary;
        foregroundColor = fpduiTheme.primaryForeground;
        if (_isHovered) backgroundColor = fpduiTheme.primary.withOpacity(0.9);
        break;
      case FpduiButtonVariant.destructive:
        backgroundColor = fpduiTheme.destructive;
        foregroundColor = fpduiTheme.destructiveForeground;
        if (_isHovered) backgroundColor = fpduiTheme.destructive.withOpacity(0.9);
        break;
      case FpduiButtonVariant.outline:
        backgroundColor = fpduiTheme.background; 
        foregroundColor = theme.colorScheme.onBackground;
        borderColor = fpduiTheme.border;
        if (_isHovered) {
          backgroundColor = fpduiTheme.accent;
          foregroundColor = fpduiTheme.accentForeground;
        }
        break;
      case FpduiButtonVariant.secondary:
        backgroundColor = fpduiTheme.secondary;
        foregroundColor = fpduiTheme.secondaryForeground;
        if (_isHovered) backgroundColor = fpduiTheme.secondary.withOpacity(0.8);
        break;
      case FpduiButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colorScheme.onBackground;
        if (_isHovered) {
          backgroundColor = fpduiTheme.accent;
          foregroundColor = fpduiTheme.accentForeground;
        }
        break;
      case FpduiButtonVariant.link:
        backgroundColor = Colors.transparent;
        foregroundColor = fpduiTheme.primary;
        break;
    }

    // Determine dimensions based on size
    double? height;
    EdgeInsetsGeometry padding;
    
    switch (widget.size) {
      case FpduiButtonSize.$default:
        height = 36; 
        padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8); 
        break;
      case FpduiButtonSize.sm:
        height = 32; 
        padding = const EdgeInsets.symmetric(horizontal: 12); 
        break;
      case FpduiButtonSize.lg:
        height = 40; 
        padding = const EdgeInsets.symmetric(horizontal: 32); 
        break;
      case FpduiButtonSize.icon:
        height = 36; 
        padding = EdgeInsets.zero;
        break;
    }

    final double effectiveRadius = fpduiTheme.radius;

    final bool isDisabled = widget.onPressed == null;
    if (isDisabled) {
      backgroundColor = backgroundColor?.withOpacity(0.5);
      foregroundColor = foregroundColor?.withOpacity(0.5);
    }

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          IconTheme(data: IconThemeData(size: 16, color: foregroundColor), child: widget.icon!),
          const Gap(8),
        ],
        if (widget.text != null)
          Text(
            widget.text!,
            style: TextStyle(
              color: foregroundColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              decoration: widget.variant == FpduiButtonVariant.link && _isHovered 
                  ? TextDecoration.underline 
                  : null,
              decorationColor: foregroundColor,
            ),
          )
        else
          widget.child!,
        if (widget.trailingIcon != null) ...[
          const Gap(8),
          IconTheme(data: IconThemeData(size: 16, color: foregroundColor), child: widget.trailingIcon!),
        ],
      ],
    );

    return MouseRegion(
      cursor: isDisabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: 150.ms,
          curve: Curves.easeInOut,
          width: widget.size == FpduiButtonSize.icon ? height : widget.width,
          height: widget.height ?? height,
          constraints: BoxConstraints(
            minWidth: widget.size == FpduiButtonSize.icon ? height : 0, 
            minHeight: height,
          ),
          padding: widget.size == FpduiButtonSize.icon ? EdgeInsets.zero : padding,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(effectiveRadius),
            border: borderColor != null ? Border.all(color: borderColor, width: 1) : null,
          ),
          child: Center(child: content),
        ),
      ),
    );
  }
}
