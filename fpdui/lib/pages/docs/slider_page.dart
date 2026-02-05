/// Responsible for displaying documentation for Slider component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: slider.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/slider.dart';
import '../../components/label.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _value = 50.0;
  double _volume = 80.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slider')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Default Slider', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            FpduiSlider(
              value: _value,
              onChanged: (val) => setState(() => _value = val),
              max: 100,
            ),
            const Gap(8),
             Text('Value: ${_value.round()}'),

            const Gap(32),
            const Text('With Label', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FpduiLabel('Volume'),
                const Gap(8),
                FpduiSlider(
                  value: _volume,
                  onChanged: (val) => setState(() => _volume = val),
                  max: 100,
                  divisions: 100, // Makes it move in 1 increments smoothly
                ),
              ],
            ),
             
             const Gap(32),
            const Text('Disabled', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
             FpduiSlider(
               value: 30,
               onChanged: (v){},
               enabled: false,
             ),
          ],
        ),
      ),
    );
  }
}
