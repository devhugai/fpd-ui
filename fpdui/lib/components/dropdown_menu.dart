import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';

// Re-using logic from ContextMenu effectively
// In a real refactor, valid to extract MenuItem logic to `menu_primitives.dart`

class FpduiDropdownMenu extends StatelessWidget {
  const FpduiDropdownMenu({
    super.key,
    required this.trigger,
    required this.items,
  });

  final Widget trigger;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Theme(
      data: theme.copyWith(
        popupMenuTheme: PopupMenuThemeData(
          color: theme.colorScheme.background,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(fpduiTheme.radius),
            side: BorderSide(color: fpduiTheme.border),
          ),
          elevation: 4, // shadow-md
        ),
      ),
      child: PopupMenuButton<void>(
        tooltip: '', // Disable default tooltip
        offset: const Offset(0, 4), // sideOffset
        padding: EdgeInsets.zero,
        itemBuilder: (context) => items.map((item) {
           if (item is FpduiDropdownMenuItem) {
            return PopupMenuItem<void>(
              height: 32,
              padding: EdgeInsets.zero,
              enabled: !item.disabled,
              onTap: item.onTap,
              child: item,
            );
          } else if (item is FpduiDropdownMenuLabel) {
             return PopupMenuItem<void>(
              height: 32,
              padding: EdgeInsets.zero,
              enabled: false,
              child: item,
            );
          } else if (item is FpduiDropdownMenuSeparator) {
             return const PopupMenuDivider(height: 1);
          }
           return PopupMenuItem<void>(child: item);
        }).cast<PopupMenuEntry<void>>().toList(),
        child: trigger,
      ),
    );
  }
}

class FpduiDropdownMenuItem extends StatelessWidget {
  const FpduiDropdownMenuItem({
    super.key,
    required this.child,
    this.leading,
    this.trailing,
    this.onTap,
    this.disabled = false,
    this.isDestructive = false,
  });

  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool disabled;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
     final fpduiTheme = theme.extension<FpduiTheme>()!;
    
    Color textColor = theme.colorScheme.onBackground;
    Color iconColor = theme.colorScheme.onBackground;
    
    if (disabled) {
      textColor = textColor.withOpacity(0.5);
      iconColor = iconColor.withOpacity(0.5);
    } else if (isDestructive) {
      textColor = theme.colorScheme.error;
      iconColor = theme.colorScheme.error;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(fpduiTheme.radius - 2),
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            IconTheme(data: IconThemeData(size: 16, color: iconColor), child: leading!),
            const Gap(8),
          ],
          Expanded(
            child: DefaultTextStyle(
              style: theme.textTheme.bodyMedium?.copyWith(
                color: textColor,
              ) ?? const TextStyle(),
              child: child,
            ),
          ),
          if (trailing != null) ...[
            const Gap(8),
            DefaultTextStyle(
               style: theme.textTheme.labelSmall?.copyWith(
                color: fpduiTheme.mutedForeground,
                letterSpacing: 1.0,
              ) ?? const TextStyle(),
              child: trailing!,
            ),
          ],
        ],
      ),
    );
  }
}

class FpduiDropdownMenuLabel extends StatelessWidget {
  const FpduiDropdownMenuLabel(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ) ?? const TextStyle(),
      ),
    );
  }
}

class FpduiDropdownMenuSeparator extends StatelessWidget {
  const FpduiDropdownMenuSeparator({super.key});

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: fpduiTheme.border,
    );
  }
}

class FpduiDropdownMenuShortcut extends StatelessWidget {
  const FpduiDropdownMenuShortcut(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
