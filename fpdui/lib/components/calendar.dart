/// Responsible for date selection and display.
/// Provides FpduiCalendar based on table_calendar.
///
/// Used by: DatePickers, scheduling views.
/// Depends on: table_calendar, fpdui_theme.
/// Assumes: focusedDay and valid date ranges.
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';
import 'button.dart'; // For navigation buttons if needed, or stick to simple IconButtons

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
  final OnDaySelected? onDaySelected;
  final void Function(DateTime)? onPageChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Container(
      // width: 280, // Removed fixed width to prevent overflow. Let it size itself or be constrained by parent.
      constraints: const BoxConstraints(maxWidth: 320), // Constraint max width for standard look
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: fpduiTheme.card,
        border: Border.all(color: fpduiTheme.border),
        borderRadius: BorderRadius.circular(fpduiTheme.radius),
      ),
      child: TableCalendar(
        focusedDay: focusedDay,
        firstDay: firstDay,
        lastDay: lastDay,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        onDaySelected: onDaySelected,
        onPageChanged: onPageChanged,
        
        // Header Style
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onBackground,
          ) ?? const TextStyle(),
          leftChevronIcon: Icon(LucideIcons.chevronLeft, size: 16, color: theme.colorScheme.onBackground),
          rightChevronIcon: Icon(LucideIcons.chevronRight, size: 16, color: theme.colorScheme.onBackground),
          leftChevronPadding: const EdgeInsets.all(4),
          rightChevronPadding: const EdgeInsets.all(4),
          leftChevronMargin: EdgeInsets.zero,
          rightChevronMargin: EdgeInsets.zero,
          headerPadding: const EdgeInsets.only(bottom: 8),
        ),
        
        // Days of Week Style
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w400,
            color: fpduiTheme.mutedForeground,
          ) ?? const TextStyle(),
          weekendStyle: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w400,
            color: fpduiTheme.mutedForeground,
          ) ?? const TextStyle(),
        ),

        // Date Cell Styles
        calendarStyle: CalendarStyle(
          defaultTextStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onBackground) ?? const TextStyle(),
          weekendTextStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onBackground) ?? const TextStyle(),
          
          // Selected
          selectedDecoration: BoxDecoration(
            color: fpduiTheme.primary,
            borderRadius: BorderRadius.circular(fpduiTheme.radius),
            shape: BoxShape.rectangle, // Explicitly set to avoid assertion conflict with default circle
          ),
          selectedTextStyle: theme.textTheme.bodyMedium?.copyWith(
            color: fpduiTheme.primaryForeground,
            fontWeight: FontWeight.normal,
          ) ?? const TextStyle(),
          
          // Today
          todayDecoration: BoxDecoration(
            color: fpduiTheme.accent,
            borderRadius: BorderRadius.circular(fpduiTheme.radius),
            shape: BoxShape.rectangle,
          ),
          todayTextStyle: theme.textTheme.bodyMedium?.copyWith(
            color: fpduiTheme.accentForeground,
            fontWeight: FontWeight.normal,
          ) ?? const TextStyle(),
          
          // Outside
          outsideTextStyle: theme.textTheme.bodyMedium?.copyWith(
            color: fpduiTheme.mutedForeground,
          ) ?? const TextStyle(),
        ),
        
        rowHeight: 40, 
      ),
    );
  }
}
