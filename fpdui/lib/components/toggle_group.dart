/// Responsible for grouping toggle buttons for selection.
/// Provides FpduiToggleGroup and FpduiToggleGroupItem.
///
/// Used by: View switchers, filters.
/// Depends on: fpdui_theme.
/// Assumes: Generic type T for values.
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
  });

  final List<FpduiToggleGroupItem<T>> items;
  
  /// Current value. 
  /// If type is single, expected T?.
  /// If type is multiple, expected List<T>.
  final dynamic value;
  
  /// Callback. 
  /// If type is single, returns T?.
  /// If type is multiple, returns List<T>.
  final ValueChanged<dynamic>? onChanged;
  
  final FpduiToggleGroupType type;

  void _handleTap(T itemValue) {
    if (onChanged == null) return;

    if (type == FpduiToggleGroupType.single) {
      if (value == itemValue) {
        onChanged!(null); // Deselect if same? Optional behavior, usually segmented buttons enforce one selection if mandatory, but toggle group usually allows none.
        // Let's assume standard toggle behavior: allows deselecting unless enforced.
        // Actually, Apple SegmentedControl enforces one. Material SegmentedButton allows empty.
        // We'll allow deselecting (toggle behavior).
      } else {
        onChanged!(itemValue);
      }
    } else {
      final List<T> currentValues = (value as List<T>?) != null ? List.from(value as List<T>) : [];
      if (currentValues.contains(itemValue)) {
        currentValues.remove(itemValue);
      } else {
        currentValues.add(itemValue);
      }
      onChanged!(currentValues);
    }
  }

  bool _isSelected(T itemValue) {
    if (type == FpduiToggleGroupType.single) {
      return value == itemValue;
    } else {
      final list = value as List<T>?;
      return list?.contains(itemValue) ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.background, // or muted/input bg
        borderRadius: BorderRadius.circular(fpduiTheme.radius),
        border: Border.all(color: fpduiTheme.input),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = _isSelected(item.value);
            final isLast = index == items.length - 1;

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: item.enabled ? () => _handleTap(item.value) : null,
                  borderRadius: BorderRadius.horizontal(
                    left: index == 0 ? Radius.circular(fpduiTheme.radius) : Radius.zero,
                    right: isLast ? Radius.circular(fpduiTheme.radius) : Radius.zero,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    color: isSelected ? fpduiTheme.accent : Colors.transparent,
                    child: DefaultTextStyle(
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: isSelected 
                            ? fpduiTheme.accentForeground 
                            : (item.enabled ? fpduiTheme.foreground : fpduiTheme.mutedForeground),
                        fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                      ),
                      child: IconTheme(
                        data: IconThemeData(
                          size: 16,
                          color: isSelected 
                              ? fpduiTheme.accentForeground 
                              : (item.enabled ? fpduiTheme.foreground : fpduiTheme.mutedForeground),
                        ),
                        child: item.child,
                      ),
                    ),
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 1,
                    color: fpduiTheme.input,
                  ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
