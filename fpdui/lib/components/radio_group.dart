import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';

class FpduiRadioGroup<T> extends StatelessWidget {
  const FpduiRadioGroup({
    super.key,
    required this.value,
    required this.onChanged,
    required this.children,
    this.direction = Axis.vertical,
    this.spacing = 12.0,
  });

  final T? value;
  final ValueChanged<T?>? onChanged;
  final List<Widget> children;
  final Axis direction;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    // We need to provide the group state to the children.
    // However, explicit composition is preferred in Flutter for clarity if not using InheritedWidget.
    // But shadcn API is: RadioGroup -> RadioGroupItem.
    // If we want that cleaner syntax, we should use InheritedWidget.
    
    return _RadioGroupScope<T>(
      value: value,
      onChanged: onChanged,
      child: direction == Axis.vertical
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: _addSpacing(children, spacing),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: _addSpacing(children, spacing),
            ),
    );
  }

  List<Widget> _addSpacing(List<Widget> base, double gap) {
    if (base.isEmpty) return base;
    final List<Widget> spaced = [];
    for (int i = 0; i < base.length; i++) {
        spaced.add(base[i]);
        if (i < base.length - 1) spaced.add(SizedBox(width: direction == Axis.horizontal ? gap : 0, height: direction == Axis.vertical ? gap : 0));
    }
    return spaced;
  }
}

class _RadioGroupScope<T> extends InheritedWidget {
  const _RadioGroupScope({
    required this.value,
    required this.onChanged,
    required super.child,
  });

  final T? value;
  final ValueChanged<T?>? onChanged;

  static _RadioGroupScope<T>? of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_RadioGroupScope<T>>();
  }

  @override
  bool updateShouldNotify(_RadioGroupScope<T> oldWidget) {
    return value != oldWidget.value || onChanged != oldWidget.onChanged;
  }
}

class FpduiRadioGroupItem<T> extends StatelessWidget {
  const FpduiRadioGroupItem({
    super.key,
    required this.value,
    this.enabled = true,
  });

  final T value;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    final group = _RadioGroupScope.of<T>(context);

    // If used without a group, it won't work interactively unless we modify to accept direct properties too.
    // But shadcn RadioGroupItem is always inside RadioGroup.
    
    final isSelected = group?.value == value;
    final onChanged = group?.onChanged;

    // shadcn specs:
    // aspect-square size-4 (16px)
    // rounded-full
    // border-input (checked: border-primary?) -> "text-primary ... border"
    // wait: "border-input text-primary ... focus-visible:ring-ring ... aspect-square size-4 ... border"
    // It doesn't explicitly say border changes color on checked, unlike Checkbox.
    // Let's check visual: Shadcn radio usually stays border-input but the inner circle is primary current color.
    // Actually typically radio border usually highlights too.
    // Radix primitive might handle it.
    // Let's assume standard behavior: Checked = primary color border + indicator.
    
    final borderColor = isSelected 
        ? theme.colorScheme.primary 
        : fpduiTheme.input; // Actually implementation says "border-input text-primary" which suggests border is ALWAYS input color, but indicator is primary.
        // But usually active state implies primary border. Let's make it primary.
    
    // Correction: "text-primary" applies to the Indicator (CircleIcon fill-primary).
    // The Container has "border-input".
    // So the border stays 'input' color usually? Or maybe `text-primary` cascades? 
    // Let's stick to standard UI convention: Active = Primary Border.

    return GestureDetector(
      onTap: (enabled && onChanged != null) ? () => onChanged(value) : null,
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : fpduiTheme.input,
            width: 1,
          ),
          color: Colors.transparent, // bg-transparent
        ),
        child: isSelected
            ? Center(
                child: Container(
                  width: 8, // size-2
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.primary, // fill-primary
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
