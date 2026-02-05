// Responsible for date selection and display.
// Provides FpduiCalendar based on CalendarDatePicker.
//
// Used by: DatePickers, scheduling views.
// Depends on: flutter/material, fpdui_theme.
// Assumes: focusedDay and valid date ranges.
import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';
// import 'button.dart';

class FpduiCalendar extends StatelessWidget {
  const FpduiCalendar({
    super.key,
    required this.focusedDay,
    required this.firstDay,
    required this.lastDay,
    this.selectedDay,
    this.onDaySelected,
    this.onPageChanged,
  });

  final DateTime focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime? selectedDay;
  final void Function(DateTime, DateTime)? onDaySelected;
  final void Function(DateTime)? onPageChanged; // Unused in CalendarDatePicker but kept for API compat if needed, though CalendarDatePicker handles it internally mostly.

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Container(
      constraints: const BoxConstraints(maxWidth: 320),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: fpduiTheme.card,
        border: Border.all(color: fpduiTheme.border),
        borderRadius: BorderRadius.circular(fpduiTheme.radius),
      ),
      child: Theme(
        data: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: fpduiTheme.primary,
            onPrimary: fpduiTheme.primaryForeground,
            surface: theme.colorScheme.surface,
            onSurface: theme.colorScheme.onSurface,
          ),
          textTheme: theme.textTheme.copyWith(
            bodyMedium: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
        child: CalendarDatePicker(
          initialDate: focusedDay,
          firstDate: firstDay,
          lastDate: lastDay,
          currentDate: selectedDay,
          onDateChanged: (value) {
            onDaySelected?.call(value, value);
          },
        ),
      ),
    );
  }
}
