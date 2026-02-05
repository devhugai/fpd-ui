/// Responsible for displaying documentation for Kbd component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: kbd.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/kbd.dart';
import 'component_page.dart';

class KbdPage extends StatelessWidget {
  const KbdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Kbd',
      description: 'Displays a keyboard shortcut or key.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text("Press "),
              FpduiKbd(child: Text("⌘")), // Cmd
              Gap(4),
              FpduiKbd(child: Text("K")),
              Text(" to search."),
            ],
          ),
          const Gap(16),
          Row(
            children: const [
              FpduiKbd(child: Text("Ctrl")),
              Gap(4),
              Text("+"),
              Gap(4),
              FpduiKbd(child: Text("C")),
            ],
          ),
        ],
      ),
    );
  }
}
