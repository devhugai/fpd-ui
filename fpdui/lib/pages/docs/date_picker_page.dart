/// Responsible for displaying documentation for Date Picker component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: date_picker.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/date_picker.dart';
import 'component_page.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({super.key});

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Date Picker',
      description: 'A date picker component using a calendar in a popover.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Basic Usage', style: Theme.of(context).textTheme.titleSmall),
          const Gap(8),
          FpduiDatePicker(
            value: selectedDate,
            onChanged: (date) {
              setState(() => selectedDate = date);
            },
          ),
          const Gap(24),
          if (selectedDate != null)
            Text('Selected: $selectedDate'),
        ],
      ),
    );
  }
}
