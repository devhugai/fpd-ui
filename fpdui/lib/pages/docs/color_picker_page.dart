/// Responsible for documenting the FpdColorPicker component.
/// Provides examples of usage.
///
/// Used by: Router.
/// Depends on: component_page, color_picker.
import 'package:flutter/material.dart';
import '../../components/color_picker.dart';
import 'component_page.dart';

class ColorPickerPage extends StatefulWidget {
  const ColorPickerPage({super.key});

  @override
  State<ColorPickerPage> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  Color _selectedColor = Colors.blue;

  final List<Color> _colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ];

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Color Picker',
      description: 'A customizable widget for selecting a color from a predefined list.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Top selected color: '),
          const SizedBox(height: 8),
          Container(
            width: 50,
            height: 50,
            color: _selectedColor,
          ),
          const SizedBox(height: 24),
          FpdColorPicker(
            colors: _colors,
            selectedColor: _selectedColor,
            onColorChanged: (color) {
              setState(() => _selectedColor = color);
            },
          ),
        ],
      ),
    );
  }
}
