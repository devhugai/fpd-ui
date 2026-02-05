// Responsible for displaying lists of items with optional search.
// Provides FpduiList and FpduiListItem.
//
// Used by: Settings, Master-Detail views, Directories.
// Depends on: fpdui_theme, input.dart.
// Assumes: Vertical scrolling.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';
import 'input.dart';

class FpduiList extends StatelessWidget {
  const FpduiList({
    super.key,
    required this.children,
    this.enableSearch = false,
    this.searchPlaceholder = 'Search...',
    this.onSearch,
    this.padding,
    this.separator,
  });

  /// The list of widgets (usually FpduiListItem) to display.
  final List<Widget> children;
  
  /// Whether to show a search bar at the top.
  final bool enableSearch;
  
  /// Placeholder text for search bar.
  final String searchPlaceholder;
  
  /// Callback when search query changes.
  final ValueChanged<String>? onSearch;
  
  /// Padding for the list view.
  final EdgeInsetsGeometry? padding;
  
  /// Widget to separate items (e.g. Divider).
  final Widget? separator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Column(
      children: [
        if (enableSearch)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FpduiInput(
              hintText: searchPlaceholder,
              prefix: Icon(LucideIcons.search, size: 16, color: fpduiTheme.mutedForeground),
              onChanged: onSearch ?? (_) {},
            ),
          ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(fpduiTheme.radius),
              border: Border.all(color: fpduiTheme.border),
            ),
            child: ListView.separated(
              padding: padding ?? const EdgeInsets.symmetric(vertical: 4),
              itemCount: children.length,
              separatorBuilder: (context, index) => separator ?? 
                 Container(height: 1, color: fpduiTheme.border.withValues(alpha: 0.5)),
              itemBuilder: (context, index) => children[index],
            ),
          ),
        ),
      ],
    );
  }
}

class FpduiListItem extends StatelessWidget {
  const FpduiListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.isDestructive = false,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        // hoverColor: fpduiTheme.accent, // Standard InkWell hover color might need adjustment to match shadcn 'muted/50'
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              if (leading != null) ...[
                IconTheme(
                  data: IconThemeData(
                    size: 20, 
                    color: isDestructive ? fpduiTheme.destructive : fpduiTheme.foreground,
                  ),
                  child: leading!,
                ),
                const Gap(16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DefaultTextStyle(
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: isDestructive ? fpduiTheme.destructive : fpduiTheme.foreground,
                      ),
                      child: title,
                    ),
                    if (subtitle != null) ...[
                      const Gap(2),
                      DefaultTextStyle(
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: fpduiTheme.mutedForeground,
                        ),
                        child: subtitle!,
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const Gap(16),
                IconTheme(
                  data: IconThemeData(
                    size: 16, 
                    color: fpduiTheme.mutedForeground,
                  ),
                  child: trailing!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
