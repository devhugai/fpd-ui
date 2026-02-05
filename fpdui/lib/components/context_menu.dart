/// Responsible for displaying contextual actions on right-click/long-press.
/// Provides FpduiContextMenu wrapper.
///
/// Used by: Lists, items requiring secondary actions.
/// Depends on: context_menus package or custom overlay, fpdui_theme.
/// Assumes: Positioned relative to mouse/touch.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';

import 'package:flutter/services.dart'; // Import services

class FpduiContextMenu extends StatefulWidget {
  const FpduiContextMenu({
    super.key,
    required this.child,
    required this.items,
  });

  final Widget child;
  final List<Widget> items;

  @override
  State<FpduiContextMenu> createState() => _FpduiContextMenuState();
}

class _FpduiContextMenuState extends State<FpduiContextMenu> {
  @override
  void initState() {
    super.initState();
    // Disable browser native context menu to allow Flutter to handle right clicks
    BrowserContextMenu.disableContextMenu();
  }

  void _showMenu(BuildContext context, Offset position) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    // Using showGeneralDialog or Overlay to show menu at position.
    // Standard showMenu is okay but styling is limited.
    // Note: showMenu allows customization of shape/color.
    // Let's try to use showMenu with heavy customization to match shadcn.
    
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      elevation: 0, // We handle shadow manually via decoration if possible, but PopupMenuButton forces elevation.
      // Actually standard PopupMenu is hard to style exactly (e.g. padding p-1).
      // Let's use it for now as "MVP context menu" but with custom MenuItems.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(fpduiTheme.radius),
        side: BorderSide(color: fpduiTheme.border),
      ),
      color: theme.colorScheme.background, // bg-popover
      surfaceTintColor: Colors.transparent,
      items: widget.items.map((item) {
        if (item is FpduiContextMenuItem) {
          return PopupMenuItem(
            height: 32, // py-1.5 -> approx 32px total height
            padding: EdgeInsets.zero,
            enabled: !item.disabled,
            onTap: item.onTap,
            child: item,
          );
        } else if (item is FpduiContextMenuLabel) {
           return PopupMenuItem(
            height: 32,
            padding: EdgeInsets.zero,
            enabled: false,
            child: item,
          );
        } else if (item is FpduiContextMenuSeparator) {
           return const PopupMenuDivider(height: 1); 
        }
        return PopupMenuItem(child: item);
      }).cast<PopupMenuEntry<dynamic>>().toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTapDown: (details) {
        _showMenu(context, details.globalPosition);
      },
      onLongPressStart: (details) {
        _showMenu(context, details.globalPosition); // Mobile support
      },
      child: widget.child,
    );
  }
}

class FpduiContextMenuItem extends StatelessWidget {
  const FpduiContextMenuItem({
    super.key,
    required this.child,
    this.leading,
    this.trailing,
    this.onTap,
    this.disabled = false,
    this.inset = false,
    this.isDestructive = false,
  });

  final Widget child;
  final Widget? leading;
  final Widget? trailing; // Shortcut or submenu indicator
  final VoidCallback? onTap;
  final bool disabled;
  final bool inset;
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
      textColor = theme.colorScheme.error; // text-destructive
      iconColor = theme.colorScheme.error;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6), // px-2 py-1.5
      margin: const EdgeInsets.symmetric(horizontal: 4), // p-1 parent wrapper usually implies margin on items or padding on parent. PopupMenu has default padding.
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(fpduiTheme.radius - 2), // rounded-sm
      ),
      child: Row(
        children: [
          if (inset && leading == null) const SizedBox(width: 16), // pl-8 if inset? No, pl-8 is 32px usually. width 16 is partial.
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
                letterSpacing: 1.0, // tracking-widest
              ) ?? const TextStyle(),
              child: trailing!,
            ),
          ],
        ],
      ),
    );
  }
}

class FpduiContextMenuLabel extends StatelessWidget {
  const FpduiContextMenuLabel(this.text, {super.key, this.inset = false});
  final String text;
  final bool inset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: inset ? 32.0 : 8.0, 
        right: 8.0, 
        top: 6.0, 
        bottom: 6.0
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ) ?? const TextStyle(),
      ),
    );
  }
}

class FpduiContextMenuSeparator extends StatelessWidget {
  const FpduiContextMenuSeparator({super.key});

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    // Used inside PopupMenu usually via PopupMenuDivider, but if used manually:
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 4), // my-1
      color: fpduiTheme.border, // bg-border
    );
  }
}

class FpduiContextMenuShortcut extends StatelessWidget {
  const FpduiContextMenuShortcut(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
