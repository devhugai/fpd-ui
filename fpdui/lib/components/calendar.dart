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
          titleTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onBackground,
          ),
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
          weekdayStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: fpduiTheme.mutedForeground,
          ),
          weekendStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: fpduiTheme.mutedForeground,
          ),
        ),

        // Date Cell Styles
        calendarStyle: CalendarStyle(
          defaultTextStyle: TextStyle(fontSize: 14, color: theme.colorScheme.onBackground),
          weekendTextStyle: TextStyle(fontSize: 14, color: theme.colorScheme.onBackground),
          
          // Selected
          selectedDecoration: BoxDecoration(
            color: fpduiTheme.primary,
            borderRadius: BorderRadius.circular(fpduiTheme.radius),
            shape: BoxShape.rectangle, // Explicitly set to avoid assertion conflict with default circle
          ),
          selectedTextStyle: TextStyle(
            fontSize: 14, 
            color: fpduiTheme.primaryForeground,
            fontWeight: FontWeight.normal,
          ),
          
          // Today
          todayDecoration: BoxDecoration(
            color: fpduiTheme.accent,
            borderRadius: BorderRadius.circular(fpduiTheme.radius),
            shape: BoxShape.rectangle,
          ),
          todayTextStyle: TextStyle(
            fontSize: 14, 
            color: fpduiTheme.accentForeground,
            fontWeight: FontWeight.normal,
          ),
          
          // Outside
          outsideTextStyle: TextStyle(
            fontSize: 14, 
            color: fpduiTheme.mutedForeground,
          ),
        ),
        
        rowHeight: 40, 
      ),
    );
  }
}
