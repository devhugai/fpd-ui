/// Responsible for displaying a horizontal menu bar.
/// Provides FpduiMenubar and FpduiMenubarItem.
///
/// Used by: Desktop applications, complex web apps.
/// Depends on: fpdui_theme, dropdown_menu.dart.
/// Assumes: Application Header usage.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';
import 'dropdown_menu.dart';

class FpduiMenubar extends StatelessWidget {
  const FpduiMenubar({
    super.key,
    required this.children,
  });

  final List<FpduiMenubarItem> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Container(
      padding: const EdgeInsets.all(4), // p-1
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        border: Border.all(color: fpduiTheme.border),
        borderRadius: BorderRadius.circular(fpduiTheme.radius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}

class FpduiMenubarItem extends StatelessWidget {
  const FpduiMenubarItem({
    super.key,
    required this.label,
    required this.children,
  });

  /// The label to display in the menubar (e.g., "File").
  final String label;

  /// The list of menu items to display when clicked.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return FpduiDropdownMenu(
      items: children,
      trigger: HoverBuilder(
        builder: (context, isHovered) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // px-3 py-1.5
            decoration: BoxDecoration(
               color: isHovered ? fpduiTheme.accent : Colors.transparent,
               borderRadius: BorderRadius.circular(fpduiTheme.radius - 2), // slightly smaller radius inside
            ),
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: isHovered ? fpduiTheme.accentForeground : theme.colorScheme.onBackground,
              ),
            ),
          );
        }
      ),
    );
  }
}

/// Simple utility for hover state handling
class HoverBuilder extends StatefulWidget {
  const HoverBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, bool isHovered) builder;

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: widget.builder(context, _isHovered),
    );
  }
}
