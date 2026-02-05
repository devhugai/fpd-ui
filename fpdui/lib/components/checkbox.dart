/// Responsible for boolean selection.
/// Provides FpduiCheckbox widget with custom styling.
///
/// Used by: Forms, settings, filters.
/// Depends on: fpdui_theme.
/// Assumes: Value changes via onChanged callback.
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
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

    // shadcn specs:
    // size-4 (16px)
    // rounded-[4px]
    // border-primary
    // checked: bg-primary text-primary-foreground
    // unchecked: border-input bg-transparent

    final borderColor = value 
        ? theme.colorScheme.primary 
        : fpduiTheme.input; // or primary based on shadcn css "border-primary" wait.
        // source: "peer border-input ... data-[state=checked]:border-primary"
    
    final backgroundColor = value 
        ? theme.colorScheme.primary 
        : Colors.transparent;

    final itemsColor = theme.colorScheme.onPrimary;

    return InkWell(
      onTap: enabled ? () => onChanged?.call(!value) : null,
      borderRadius: BorderRadius.circular(fpduiTheme.radiusSm),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(fpduiTheme.radiusSm),
        ),
        child: value
            ? Icon(
                LucideIcons.check,
                size: 12,
                color: itemsColor,
              )
            : null,
      ),
    );
  }
}
