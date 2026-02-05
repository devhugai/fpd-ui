/// Responsible for displaying documentation for Calendar component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: calendar.dart, component_page.
import 'package:flutter/material.dart';
import '../../components/calendar.dart';
import '../../components/card.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Date Picker / Calendar', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            FpduiCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              selectedDay: _selectedDay,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 16),
             Text("Selected Date: ${_selectedDay?.toLocal().toString().split(' ')[0]}"),
          ],
        ),
      ),
    );
  }
}
