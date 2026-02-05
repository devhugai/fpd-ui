/// Responsible for displaying all available text styles in the theme.
/// Provides visual reference for typography tokens.
///
/// Used by: Router, Designers.
/// Depends on: component_page, fpdui_theme.
/// Assumes: Theme textTheme is populated.
import 'package:flutter/material.dart';
import '../../components/card.dart';
import '../../components/separator.dart';

class TypographyPage extends StatelessWidget {
  const TypographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Typography', style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'Styles for headings, paragraphs, lists... etc',
              style: textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6)),
            ),
            const SizedBox(height: 32),
            const FpduiSeparator(),
            const SizedBox(height: 32),

            _TypographyItem(name: 'Display Large', style: textTheme.displayLarge!, text: 'The quick brown fox jumps over the lazy dog'),
            _TypographyItem(name: 'Display Medium', style: textTheme.displayMedium!, text: 'The quick brown fox jumps over the lazy dog'),
            _TypographyItem(name: 'Display Small', style: textTheme.displaySmall!, text: 'The quick brown fox jumps over the lazy dog'),
            
            const SizedBox(height: 24),
            const FpduiSeparator(),
            const SizedBox(height: 24),

            _TypographyItem(name: 'Headline Large', style: textTheme.headlineLarge!, text: 'The quick brown fox jumps over the lazy dog'),
            _TypographyItem(name: 'Headline Medium', style: textTheme.headlineMedium!, text: 'The quick brown fox jumps over the lazy dog'),
            _TypographyItem(name: 'Headline Small', style: textTheme.headlineSmall!, text: 'The quick brown fox jumps over the lazy dog'),

            const SizedBox(height: 24),
            const FpduiSeparator(),
            const SizedBox(height: 24),

            _TypographyItem(name: 'Title Large', style: textTheme.titleLarge!, text: 'The quick brown fox jumps over the lazy dog'),
            _TypographyItem(name: 'Title Medium', style: textTheme.titleMedium!, text: 'The quick brown fox jumps over the lazy dog'),
            _TypographyItem(name: 'Title Small', style: textTheme.titleSmall!, text: 'The quick brown fox jumps over the lazy dog'),

            const SizedBox(height: 24),
            const FpduiSeparator(),
            const SizedBox(height: 24),

            _TypographyItem(name: 'Body Large', style: textTheme.bodyLarge!, text: 'The quick brown fox jumps over the lazy dog'),
            _TypographyItem(name: 'Body Medium', style: textTheme.bodyMedium!, text: 'The quick brown fox jumps over the lazy dog'),
            _TypographyItem(name: 'Body Small', style: textTheme.bodySmall!, text: 'The quick brown fox jumps over the lazy dog'),

            const SizedBox(height: 24),
            const FpduiSeparator(),
            const SizedBox(height: 24),

            _TypographyItem(name: 'Label Large', style: textTheme.labelLarge!, text: 'The quick brown fox jumps over the lazy dog'),
            _TypographyItem(name: 'Label Medium', style: textTheme.labelMedium!, text: 'The quick brown fox jumps over the lazy dog'),
            _TypographyItem(name: 'Label Small', style: textTheme.labelSmall!, text: 'The quick brown fox jumps over the lazy dog'),
          ],
        ),
      ),
    );
  }
}

class _TypographyItem extends StatelessWidget {
  const _TypographyItem({
    required this.name,
    required this.style,
    required this.text,
  });

  final String name;
  final TextStyle style;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FpduiCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey)),
              const SizedBox(height: 8),
              Text(
                text,
                style: style,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                'Size: ${style.fontSize?.toStringAsFixed(1)}px | Weight: ${style.fontWeight}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(fontFamily: 'monospace', color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
