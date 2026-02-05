// Responsible for grouping toggle buttons for selection.
// Provides FpduiToggleGroup and FpduiToggleGroupItem.
//
// Used by: View switchers, filters.
// Depends on: fpdui_theme.
// Assumes: Generic type T for values.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

enum FpduiToggleGroupType {
  single,
  multiple,
}

class FpduiToggleGroupItem<T> {
  final T value;
  final Widget child;
  final String? tooltip;
  final bool enabled;

  const FpduiToggleGroupItem({
    required this.value,
    required this.child,
    this.tooltip,
    this.enabled = true,
  });
}

class FpduiToggleGroup<T> extends StatelessWidget {
  const FpduiToggleGroup({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.type = FpduiToggleGroupType.single,
    this.emptySelectionAllowed = true,
  });

  final List<FpduiToggleGroupItem<T>> items;
  
  // Current value. 
  // If type is single, expects `T?` (or `T` if not empty allowed).
  // If type is multiple, expects `List<T>` or `Set<T>`.
  final dynamic value;
  
  // Callback. 
  // If type is single, returns `T?`.
  // If type is multiple, returns `List<T>`.
  final ValueChanged<dynamic>? onChanged;
  
  final FpduiToggleGroupType type;
  final bool emptySelectionAllowed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    // Prepare segments
    final List<ButtonSegment<T>> segments = items.map((item) {
      return ButtonSegment<T>(
        value: item.value,
        icon: item.child, // FpduiToggleGroup usually just has child (icon/text). SegmentedButton uses icon/label.
                          // We map child to icon for compact look, or label if text. 
                          // Let's assume child is the main content.
        // mapping child to label might be safer if it's text, but child is Widget.
        // Let's use label for general purpose.
        label: item.child, 
        enabled: item.enabled,
        tooltip: item.tooltip,
      );
    }).toList();

    // Prepare selection
    Set<T> selected = {};
    if (type == FpduiToggleGroupType.single) {
      if (value != null) {
        selected = {value as T};
      }
    } else {
      if (value != null) {
        selected = (value as List<T>).toSet();
      }
    }

    return SegmentedButton<T>(
      segments: segments,
      selected: selected,
      onSelectionChanged: (newSelection) {
        if (onChanged == null) return;

        if (type == FpduiToggleGroupType.single) {
           if (newSelection.isEmpty) {
             onChanged!(null);
           } else {
             onChanged!(newSelection.first);
           }
        } else {
          onChanged!(newSelection.toList());
        }
      },
      multiSelectionEnabled: type == FpduiToggleGroupType.multiple,
      emptySelectionAllowed: emptySelectionAllowed, // Default true to allow toggle behavior
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return fpduiTheme.accent;
          }
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return fpduiTheme.accentForeground;
          }
          return fpduiTheme.foreground;
        }),
        side: WidgetStateProperty.all(BorderSide(color: fpduiTheme.input)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(fpduiTheme.radius)),
        ),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
        visualDensity: VisualDensity.compact,
      ),
      showSelectedIcon: false, // Don't show the checkmark to match toggle group style
    );
  }
}
