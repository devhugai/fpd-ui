/// Responsible for top and bottom app bars.
/// Provides FpduiAppBar and FpduiBottomAppBar.
///
/// Used by: Scaffolds.
/// Depends on: fpdui_theme.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FpduiAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.bottom,
    this.centerTitle = false,
  });

  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return AppBar(
      title: title,
      centerTitle: centerTitle,
      actions: actions,
      leading: leading,
      bottom: bottom,
      backgroundColor: theme.colorScheme.background,
      foregroundColor: theme.colorScheme.onBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      shape: Border(
        bottom: BorderSide(
          color: fpduiTheme.border,
          width: 1,
        ),
      ),
      titleTextStyle: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.onBackground,
      ),
      iconTheme: IconThemeData(
        color: theme.colorScheme.onBackground,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}

class FpduiBottomAppBar extends StatelessWidget {
  const FpduiBottomAppBar({
    super.key,
    required this.child,
    this.height,
  });

  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return BottomAppBar(
      height: height,
      color: theme.colorScheme.background,
      surfaceTintColor: Colors.transparent, // Disable tint
      elevation: 0,
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: fpduiTheme.border, width: 1),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: child,
      ),
    );
  }
}
