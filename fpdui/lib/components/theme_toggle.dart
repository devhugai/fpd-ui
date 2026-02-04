import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'button.dart';
import 'popover.dart';
import 'theme_configurator.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    // We can use a controller if we want programmatic control, but for simple toggle, maybe just let Popover handle it?
    // The example showed using a controller.
    // Let's create a local controller.
    // Since this is StatelessWidget, we can't persist the controller easily without it being created outside or using a StatefulWidget.
    // Let's convert to StatefulWidget.
    return const _ThemeToggleStateful();
  }
}

class _ThemeToggleStateful extends StatefulWidget {
  const _ThemeToggleStateful();

  @override
  State<_ThemeToggleStateful> createState() => __ThemeToggleStatefulState();
}

class __ThemeToggleStatefulState extends State<_ThemeToggleStateful> {
  final FpduiPopoverController _controller = FpduiPopoverController();

  @override
  Widget build(BuildContext context) {
    return FpduiPopover(
      controller: _controller,
      content: const SizedBox(
        width: 300,
        child: ThemeConfigurator(),
      ),
      child: FpduiButton(
        size: FpduiButtonSize.icon,
        variant: FpduiButtonVariant.ghost,
        child: const Icon(LucideIcons.settings2, size: 20),
        onPressed: () {
          _controller.toggle();
        },
      ),
    );
  }
}
