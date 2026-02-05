/// Responsible for displaying draggable bottom sheets.
/// Provides FpduiDrawer utils and widgets.
///
/// Used by: Mobile interactions, detail views on small screens.
/// Depends on: fpdui_theme.
/// Assumes: Bottom anchorage.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../theme/fpdui_theme.dart';

class FpduiDrawer {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget content,
    bool isScrollControlled = true,
  }) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent, // We wrap content
      builder: (context) => _DrawerContainer(content: content),
    );
  }
}

class _DrawerContainer extends StatelessWidget {
  const _DrawerContainer({required this.content});
  final Widget content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(fpduiTheme.radiusLg)),
        border: Border(
           top: BorderSide(color: fpduiTheme.border),
           // Side borders optional, but sticking to simple top rounded card look
        ),
      ),
      padding: const EdgeInsets.only(top: 8.0), // Space for handle
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Center(
            child: Container(
              width: 100,
              height: 6,
              decoration: BoxDecoration(
                color: fpduiTheme.muted,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          const Gap(24),
          Flexible(child: content),
          const Gap(24), // Bottom safe area usually handled by OS or padding
        ],
      ),
    );
  }
}

class FpduiDrawerHeader extends StatelessWidget {
  const FpduiDrawerHeader({
    super.key,
    required this.title,
    this.description,
  });

  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onBackground,
            ),
            textAlign: TextAlign.center,
          ),
          if (description != null) ...[
            const Gap(4),
            Text(
              description!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: fpduiTheme.mutedForeground,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class FpduiDrawerFooter extends StatelessWidget {
  const FpduiDrawerFooter({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children.map((e) => Padding(
          padding: EdgeInsets.only(top: children.indexOf(e) > 0 ? 8.0 : 0),
          child: e,
        )).toList(),
      ),
    );
  }
}
