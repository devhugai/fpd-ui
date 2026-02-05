// Responsible for boolean selection.
// Provides FpduiCheckbox widget with custom styling.
//
// Used by: Forms, settings, filters.
// Depends on: fpdui_theme.
// Assumes: Value changes via onChanged callback.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiCheckbox extends StatelessWidget {
  const FpduiCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.enabled = true,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Transform.scale(
      scale: 1.0, // Adjust if needed to match 16px visual size, but standard is fine
      child: Checkbox(
        value: value,
        onChanged: enabled ? (v) => onChanged?.call(v ?? false) : null,
        activeColor: fpduiTheme.primary,
        checkColor: fpduiTheme.primaryForeground,
        side: BorderSide(color: fpduiTheme.input, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(fpduiTheme.radiusSm)),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        splashRadius: 0, // No ripple for clean shadcn look, or keep it for better feedback
      ),
    );
  }
}


