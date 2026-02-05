// Responsible for selecting items from a large list with search.
// Provides FpduiCombobox and ComboboxItem.
//
// Used by: Forms, filters.
// Depends on: popover.dart, command.dart, button.dart.
// Assumes: Popover handles overlay.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';
import 'popover.dart';
import 'command.dart';
import 'button.dart';

class ComboboxItem<T> {
  final T value;
  final String label;
  final bool disabled;

  const ComboboxItem({
    required this.value,
    required this.label,
    this.disabled = false,
  });
}

class FpduiCombobox<T> extends StatefulWidget {
  const FpduiCombobox({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.placeholder = "Select option...",
    this.searchPlaceholder = "Search...",
    this.noResultsText = "No results found.",
    this.width = 200,
  });

  final List<ComboboxItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String placeholder;
  final String searchPlaceholder;
  final String noResultsText;
  final double width;

  @override
  State<FpduiCombobox<T>> createState() => _FpduiComboboxState<T>();
}

class _FpduiComboboxState<T> extends State<FpduiCombobox<T>> {
  final FpduiPopoverController _popoverController = FpduiPopoverController();
  
  // Local filtering state
  String _searchQuery = '';
  
  @override
  Widget build(BuildContext context) {
    // Find selected label
    final selectedItem = widget.items.where((i) => i.value == widget.value).firstOrNull;
    final displayLabel = selectedItem?.label ?? widget.placeholder;
    final isPlaceholder = selectedItem == null;

    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return FpduiPopover(
      controller: _popoverController,
      width: widget.width,
      content: _buildCommandContent(context),
      onOpenChange: (isOpen) {
        if (!isOpen) {
          setState(() => _searchQuery = ''); // Reset search on close
        }
      },
      child: FpduiButton(
        variant: FpduiButtonVariant.outline,
        size: FpduiButtonSize.$default, // Explicit default
        onPressed: _popoverController.toggle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                displayLabel,
                style: isPlaceholder 
                    ? TextStyle(fontWeight: FontWeight.normal, color: fpduiTheme.mutedForeground) 
                    : const TextStyle(fontWeight: FontWeight.normal),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Gap(8),
            Icon(LucideIcons.chevronsUpDown, size: 16, color: fpduiTheme.mutedForeground), // opacity-50
          ],
        ),
      ),
    );
  }

  Widget _buildCommandContent(BuildContext context) {
    // Filter items
    final filteredItems = widget.items.where((item) {
      if (_searchQuery.isEmpty) return true;
      return item.label.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return FpduiCommand(
      children: [
        FpduiCommandInput(
          placeholder: widget.searchPlaceholder,
          onChanged: (val) => setState(() => _searchQuery = val),
        ),
        FpduiCommandList(
          children: [
             if (filteredItems.isEmpty)
               FpduiCommandEmpty(widget.noResultsText),
             
             if (filteredItems.isNotEmpty)
               FpduiCommandGroup(
                 heading: "Options", // Optional or generic
                 children: filteredItems.map((item) {
                   final isSelected = item.value == widget.value;
                   return FpduiCommandItem(
                     disabled: item.disabled,
                     onSelect: () {
                       widget.onChanged?.call(item.value);
                       _popoverController.hide();
                     },
                     selected: isSelected, // Checkmark visual usually, or bg highlight. 
                     // Shadcn Combobox uses a Check icon on the left, and standard item style.
                     // Our CommandItem handles 'selected' visual style (bg color).
                     // Ideally we want Check Icon + Label.
                     child: Row(
                       children: [
                         Icon(
                            LucideIcons.check, 
                            size: 16, 
                            color: isSelected ? null : Colors.transparent
                         ), // Use 'null' to inherit text color or accentForeground
                         const Gap(8),
                         Text(item.label),
                       ],
                     ),
                   );
                 }).toList(),
               ),
          ],
        ),
      ],
    );
  }
}
