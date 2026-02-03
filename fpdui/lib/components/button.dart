import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import '../theme/shadcn_theme.dart';

enum ShadcnButtonVariant {
  primary,
  destructive,
  outline,
  secondary,
  ghost,
  link,
}

enum ShadcnButtonSize {
  $default,
  sm,
  lg,
  icon,
}

class ShadcnButton extends StatefulWidget {
  const ShadcnButton({
    super.key,
    this.variant = ShadcnButtonVariant.primary,
    this.size = ShadcnButtonSize.$default,
    this.onPressed,
    this.child,
    this.text,
    this.icon,
    this.trailingIcon,
    this.width,
    this.height,
  }) : assert(child != null || text != null, 'Either child or text must be provided');

  final ShadcnButtonVariant variant;
  final ShadcnButtonSize size;
  final VoidCallback? onPressed;
  final Widget? child;
  final String? text;
  final Widget? icon;
  final Widget? trailingIcon;
  final double? width;
  final double? height;

  @override
  State<ShadcnButton> createState() => _ShadcnButtonState();
}

class _ShadcnButtonState extends State<ShadcnButton> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shadcnTheme = theme.extension<ShadcnTheme>()!;
    
    // Determine colors based on variant
    Color? backgroundColor;
    Color? foregroundColor;
    Color? borderColor;
    
    switch (widget.variant) {
      case ShadcnButtonVariant.primary:
        backgroundColor = shadcnTheme.primary;
        foregroundColor = shadcnTheme.primaryForeground;
        if (_isHovered) backgroundColor = shadcnTheme.primary.withOpacity(0.9);
        break;
      case ShadcnButtonVariant.destructive:
        backgroundColor = shadcnTheme.destructive;
        foregroundColor = shadcnTheme.destructiveForeground;
        if (_isHovered) backgroundColor = shadcnTheme.destructive.withOpacity(0.9);
        break;
      case ShadcnButtonVariant.outline:
        backgroundColor = shadcnTheme.background; // Usually transparent or background
        foregroundColor = theme.colorScheme.onBackground;
        borderColor = shadcnTheme.border;
        if (_isHovered) {
          backgroundColor = shadcnTheme.accent;
          foregroundColor = shadcnTheme.accentForeground;
        }
        break;
      case ShadcnButtonVariant.secondary:
        backgroundColor = shadcnTheme.secondary;
        foregroundColor = shadcnTheme.secondaryForeground;
        if (_isHovered) backgroundColor = shadcnTheme.secondary.withOpacity(0.8);
        break;
      case ShadcnButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colorScheme.onBackground;
        if (_isHovered) {
          backgroundColor = shadcnTheme.accent;
          foregroundColor = shadcnTheme.accentForeground;
        }
        break;
      case ShadcnButtonVariant.link:
        backgroundColor = Colors.transparent;
        foregroundColor = shadcnTheme.primary;
        // Hover underline handled in content usually, but here we might just not change bg
        break;
    }

    // Determine dimensions based on size
    double? height;
    EdgeInsetsGeometry padding;
    
    switch (widget.size) {
      case ShadcnButtonSize.$default:
        height = 36; // h-9 = 2.25rem = 36px
        padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8); // px-4 py-2
        break;
      case ShadcnButtonSize.sm:
        height = 32; // h-8 = 2rem = 32px
        padding = const EdgeInsets.symmetric(horizontal: 12); // px-3
        break;
      case ShadcnButtonSize.lg:
        height = 40; // h-10 = 2.5rem = 40px
        padding = const EdgeInsets.symmetric(horizontal: 32); // px-8
        break;
      case ShadcnButtonSize.icon:
        height = 36; // h-9
        padding = EdgeInsets.zero;
        break;
    }

    final double effectiveWidth = widget.size == ShadcnButtonSize.icon ? height : (widget.width ?? double.infinity);
    final double radius = shadcnTheme.radius;

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
              decoration: widget.variant == ShadcnButtonVariant.link && _isHovered 
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
          width: widget.size == ShadcnButtonSize.icon ? height : widget.width, // Don't force infinity if not needed
          height: widget.height ?? height,
          constraints: BoxConstraints(
            minWidth: widget.size == ShadcnButtonSize.icon ? height : 0, 
            minHeight: height,
          ),
          padding: widget.size == ShadcnButtonSize.icon ? EdgeInsets.zero : padding,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(radius),
            border: borderColor != null ? Border.all(color: borderColor, width: 1) : null,
          ),
          child: Center(child: content),
        ),
      ),
    );
  }
}
