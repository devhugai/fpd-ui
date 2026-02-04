import 'package:flutter/material.dart';
import '../../components/accordion.dart';

class AccordionPage extends StatelessWidget {
  const AccordionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accordion')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FpduiAccordion(
              type: FpduiAccordionType.single,
              children: const [
                 FpduiAccordionItem(
                  value: 'item-1',
                  trigger: Text('Is it accessible?'),
                  content: Text('Yes. It adheres to the WAI-ARIA design pattern.'),
                ),
                 FpduiAccordionItem(
                  value: 'item-2',
                  trigger: Text('Is it styled?'),
                  content: Text('Yes. It comes with default styles that matches the other components\' aesthetic.'),
                ),
                 FpduiAccordionItem(
                  value: 'item-3',
                  trigger: Text('Is it animated?'),
                  content: Text('Yes. It\'s animated by default, but you can disable it if you prefer.'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
