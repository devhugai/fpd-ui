/// Responsible for displaying documentation for Time Picker.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: time_picker.dart, component_page.
import 'package:flutter/material.dart';
import '../../components/time_picker.dart';
import 'component_page.dart';
import '../../components/button.dart';

class TimePickerPage extends StatefulWidget {
  const TimePickerPage({super.key});

  @override
  State<TimePickerPage> createState() => _TimePickerPageState();
}

class _TimePickerPageState extends State<TimePickerPage> {
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Time Picker',
      description: 'Material Design time picker styled for FPDUI.',
      child: Center(
        child: Column(
          children: [
            FpduiButton(
              onPressed: () async {
                final time = await showFpduiTimePicker(
                  context: context,
                  initialTime: _selectedTime ?? TimeOfDay.now(),
                );
                if (time != null) {
                  setState(() => _selectedTime = time);
                }
              },
              child: const Text('Pick a time'),
            ),
            if (_selectedTime != null) ...[
              const SizedBox(height: 16),
              Text('Selected: ${_selectedTime!.format(context)}'),
            ],
          ],
        ),
      ),
    );
  }
}
