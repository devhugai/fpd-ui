import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'theme_configurator.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(LucideIcons.settings2, size: 20),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: ThemeConfigurator(),
            );
          },
        );
      },
    );
  }
}
