// Responsible for selecting a value from a list of options.
// Provides FpduiSelect and FpduiSelectItem.
//
// Used by: Forms, filters.
// Depends on: fpdui_theme, lucide_icons.
// Assumes: Popover-style dropdown behavior.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';

class FpduiSelectItem<T> {
  final T value;
  final Widget child;
  final bool enabled;

  const FpduiSelectItem({
    required this.value,
    required this.child,
    this.enabled = true,
  });
}

class FpduiSelect<T> extends StatefulWidget {
  const FpduiSelect({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    this.placeholder,
    this.width,
  });

  final T? value;
  final ValueChanged<T> onChanged;
  final List<FpduiSelectItem<T>> items;
  final Widget? placeholder;
  final double? width;

  @override
  State<FpduiSelect<T>> createState() => _FpduiSelectState<T>();
}

class _FpduiSelectState<T> extends State<FpduiSelect<T>> {
  final MenuController _menuController = MenuController();

  void _select(T value) {
    widget.onChanged(value);
    _menuController.close();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    // Find selected item widget to display
    final selectedItem = widget.items.where((i) => i.value == widget.value).firstOrNull;
    Widget? displayContent = selectedItem?.child;
    if (displayContent == null && widget.placeholder != null) {
      displayContent = DefaultTextStyle(
        style: theme.textTheme.bodyMedium!.copyWith(color: fpduiTheme.mutedForeground),
        child: widget.placeholder!,
      );
    }
    displayContent ??= const SizedBox();

    return MenuAnchor(
      controller: _menuController,
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(fpduiTheme.popover),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(fpduiTheme.radius),
              side: BorderSide(color: fpduiTheme.border),
          ),
        ),
        elevation: const WidgetStatePropertyAll(4),
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      ),
      menuChildren: widget.items.map((item) {
        final isSelected = item.value == widget.value;
        return MenuItemButton(
          onPressed: item.enabled ? () => _select(item.value) : null,
          style: ButtonStyle(
             backgroundColor: WidgetStateProperty.resolveWith((states) {
               if (isSelected) return fpduiTheme.accent;
               if (states.contains(WidgetState.hovered)) return fpduiTheme.accent; // Hover effect
               return Colors.transparent;
             }),
             padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
          ),
          child: SizedBox(
            width: (widget.width ?? 200) - 16, // constraint width to match trigger roughly
            child: Row(
              children: [
                SizedBox(
                  width: 16,
                  child: isSelected
                      ? Icon(LucideIcons.check, size: 14, color: fpduiTheme.accentForeground)
                      : null,
                ),
                const Gap(8),
                Expanded(
                  child: DefaultTextStyle(
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: item.enabled 
                          ? (isSelected ? fpduiTheme.accentForeground : fpduiTheme.popoverForeground)
                          : fpduiTheme.mutedForeground,
                      fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                    ),
                    child: item.child,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
      builder: (context, controller, child) {
        return InkWell(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          borderRadius: BorderRadius.circular(fpduiTheme.radius),
          child: Container(
            height: 40,
            width: widget.width,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(fpduiTheme.radius),
              border: Border.all(color: fpduiTheme.input),
              color: theme.colorScheme.surface,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DefaultTextStyle(
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                    child: displayContent is Widget ? displayContent : Text((displayContent ?? '').toString()),
                  ),
                ),
                Icon(LucideIcons.chevronDown, size: 16, color: fpduiTheme.mutedForeground.withValues(alpha: 0.5)),
              ],
            ),
          ),
        );
      },
    );
  }
}
