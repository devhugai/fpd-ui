// Responsible for time selection.
// Provides showFpduiTimePicker utility.
//
// Used by: Forms, scheduling.
// Depends on: fpdui_theme.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

/// Shows a Material Time Picker styled to match FPDUI.
Future<TimeOfDay?> showFpduiTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
}) {
  final theme = Theme.of(context);
  final fpduiTheme = theme.extension<FpduiTheme>()!;

  return showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (context, child) {
      return Theme(
        data: theme.copyWith(
          timePickerTheme: TimePickerThemeData(
            backgroundColor: fpduiTheme.popover,
            dialHandColor: fpduiTheme.primary,
            dialBackgroundColor: fpduiTheme.muted,
            hourMinuteTextColor: fpduiTheme.foreground,
            hourMinuteColor: WidgetStateColor.resolveWith((states) {
               if (states.contains(WidgetState.selected)) {
                 return fpduiTheme.primary.withValues(alpha: 0.1);
               }
               return fpduiTheme.muted;
            }),
            hourMinuteTextStyle: theme.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
            dayPeriodColor: WidgetStateColor.resolveWith((states) {
               if (states.contains(WidgetState.selected)) {
                 return fpduiTheme.primary.withValues(alpha: 0.1);
               }
               return Colors.transparent;
            }),
            dayPeriodTextColor: WidgetStateColor.resolveWith((states) {
               if (states.contains(WidgetState.selected)) {
                 return fpduiTheme.primary;
               }
               return fpduiTheme.mutedForeground;
            }),
            dialTextColor: WidgetStateColor.resolveWith((states) {
               if (states.contains(WidgetState.selected)) {
                 return theme.colorScheme.onPrimary;
               }
               return fpduiTheme.foreground;
            }),
            entryModeIconColor: fpduiTheme.mutedForeground,
            helpTextStyle: theme.textTheme.labelSmall?.copyWith(color: fpduiTheme.mutedForeground),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(fpduiTheme.radius)),
            confirmButtonStyle: ButtonStyle(
               foregroundColor: WidgetStateProperty.all(fpduiTheme.primary),
            ),
            cancelButtonStyle: ButtonStyle(
               foregroundColor: WidgetStateProperty.all(fpduiTheme.mutedForeground),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: fpduiTheme.primary,
            ),
          ),
        ),
        child: child!,
      );
    },
  );
}
