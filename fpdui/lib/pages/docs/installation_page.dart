import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../theme/fpdui_theme.dart';
import 'component_page.dart';

class InstallationPage extends StatelessWidget {
  const InstallationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'Installation',
      description: 'How to install dependencies and structure your app.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '1. Create project',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Gap(8),
          Text(
            'flutter create my_app',
            style: TextStyle(fontFamily: 'monospace'),
          ),
          Gap(16),
          Text(
            '2. Add dependencies',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Gap(8),
          Text(
            'flutter pub add flutter_animate flutter_riverpod lucide_icons google_fonts gap',
            style: TextStyle(fontFamily: 'monospace'),
          ),
        ],
      ),
    );
  }
}
