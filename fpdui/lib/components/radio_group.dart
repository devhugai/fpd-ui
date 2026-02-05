// Responsible for single choice selection from a set.
// Provides FpduiRadioGroup and FpduiRadioGroupItem.
//
// Used by: Forms, settings.
// Depends on: fpdui_theme.
// Assumes: Only one item selected at a time.
import 'package:flutter/material.dart';
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

    // final isSelected = group?.value == value;
    final onChanged = group?.onChanged;

    return SizedBox(
      width: 16, 
      height: 16,
      child: Radio<T>(
        value: value,
        // ignore: deprecated_member_use
        groupValue: group?.value,
        // ignore: deprecated_member_use
        onChanged: (enabled && onChanged != null) ? onChanged : null,
        activeColor: fpduiTheme.primary,
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return fpduiTheme.primary;
          }
          return fpduiTheme.input; // Unselected border color essentially
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        splashRadius: 0,
      ),
    );
  }
}


