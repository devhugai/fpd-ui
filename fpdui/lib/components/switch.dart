// Responsible for boolean toggle.
// Provides FpduiSwitch widget.
//
// Used by: Settings, activation states.
// Depends on: fpdui_theme.
// Assumes: Boolean state controlled via onChanged.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiSwitch extends StatelessWidget {
  const FpduiSwitch({
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
      scale: 0.8, // Shadcn switch is small (h-5 w-9). Native is larger.
      alignment: Alignment.centerLeft,
      child: Switch(
        value: value,
        onChanged: enabled ? onChanged : null,
        activeThumbColor: theme.colorScheme.surface, // Thumb color when active (white)
        activeTrackColor: fpduiTheme.primary, // Track color when active (primary)
        
        inactiveThumbColor: theme.colorScheme.surface, // Thumb color when inactive
        inactiveTrackColor: fpduiTheme.input, // Track color when inactive
        
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
        splashRadius: 0,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}


