/// Responsible for selecting a date via a calendar popover.
/// Provides FpduiDatePicker widget.
///
/// Used by: Forms, scheduling.
/// Depends on: calendar.dart, popover.dart, button.dart, intl.
/// Assumes: Single date selection.
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';
import 'button.dart';
import 'calendar.dart';
import 'popover.dart';
import 'package:gap/gap.dart';

class FpduiDatePicker extends StatefulWidget {
  const FpduiDatePicker({
    super.key,
    this.value,
    required this.onChanged,
    this.placeholder = 'Pick a date',
  });

  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final String placeholder;

  @override
  State<FpduiDatePicker> createState() => _FpduiDatePickerState();
}

class _FpduiDatePickerState extends State<FpduiDatePicker> {
  final FpduiPopoverController _popoverController = FpduiPopoverController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    final displayText = widget.value != null 
        ? DateFormat.yMMMd().format(widget.value!) 
        : widget.placeholder;

    return FpduiPopover(
      controller: _popoverController,
      content: FpduiCalendar(
        focusedDay: widget.value ?? DateTime.now(), // Required param focusedDay was missing too in cal usage!
        firstDay: DateTime(1900),
        lastDay: DateTime(2100),
        selectedDay: widget.value,
        onDaySelected: (selectedDay, focusedDay) {
          widget.onChanged(selectedDay);
          _popoverController.hide();
        },
      ),
      child: FpduiButton(
        variant: FpduiButtonVariant.outline,
         // We might want formatting closer to the shadcn Button(variant="outline") + justify config
         // But reusing FpduiButton is easiest.
         // We'll mimic the look:
        onPressed: _popoverController.toggle,
        child: Row(
          mainAxisSize: MainAxisSize.min, // or max depending on desired width
          children: [
            Icon(LucideIcons.calendar, size: 16, 
               color: widget.value == null ? fpduiTheme.mutedForeground : null),
            const Gap(8),
            Text(
              displayText,
              style: TextStyle(
                color: widget.value == null ? fpduiTheme.mutedForeground : null,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
