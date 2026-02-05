// Responsible for displaying keyboard shortcuts independently.
// Provides FpduiKbd widget.
//
// Used by: Documentation, command palettes, tooltips.
// Depends on: fpdui_theme.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiKbd extends StatelessWidget {
  const FpduiKbd({
    super.key,
    required this.child,
    this.fontSize,
  });

  final Widget child;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), // px-1.5
      decoration: BoxDecoration(
        color: fpduiTheme.muted,
        borderRadius: BorderRadius.circular(fpduiTheme.radius - 2), // rounded (usually small)
        border: Border.all(color: fpduiTheme.border, width: 1),
        // Optional: Add shadow to simulate key depth like shadcn
        boxShadow: [
          BoxShadow(
            color: fpduiTheme.border,
            offset: const Offset(0, 1), // border-b-2 feel
            blurRadius: 0,
          ),
        ],
      ),
      child: DefaultTextStyle.merge(
        style: theme.textTheme.labelSmall?.copyWith(
          fontFamily: 'monospace', // Monospace usually
          fontSize: fontSize ?? 12,
          color: fpduiTheme.mutedForeground,
          fontWeight: FontWeight.w500,
        ) ?? const TextStyle(fontFamily: 'monospace'),
        child: child,
      ),
    );
  }
}
