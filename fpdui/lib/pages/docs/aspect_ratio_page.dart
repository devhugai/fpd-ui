/// Responsible for displaying documentation for Aspect Ratio component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: aspect_ratio.dart, component_page.
import 'package:flutter/material.dart';
import '../../components/aspect_ratio.dart';
import 'component_page.dart';

class AspectRatioPage extends StatelessWidget {
  const AspectRatioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ComponentPage(
      name: 'Aspect Ratio',
      description: 'Displays content within a desired ratio.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 450,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: FpduiAspectRatio(
              ratio: 16 / 9,
              child: Image.network(
                'https://images.unsplash.com/photo-1588345921523-c2dcdb7f1dcd?w=800&dpr=2&q=80',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '16:9 Aspect Ratio',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
