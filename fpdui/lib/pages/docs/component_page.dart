import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ComponentPage extends StatelessWidget {
  const ComponentPage({
    super.key,
    required this.name,
    this.description,
    required this.child,
  });

  final String name;
  final String? description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          if (description != null) ...[
            const Gap(8),
            Text(description!, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6))),
          ],
          const Gap(32),
          child,
        ],
      ),
    );
  }
}
