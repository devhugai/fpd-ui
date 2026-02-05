/// Responsible for containerizing content with standard styling.
/// Provides FpduiCard, CardHeader, CardTitle, CardContent, CardFooter.
///
/// Used by: Dashboards, complex lists, data display.
/// Depends on: fpdui_theme.
/// Assumes: Modular composition of sub-widgets.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../theme/fpdui_theme.dart';

class FpduiCard extends StatelessWidget {
  const FpduiCard({
    super.key,
    required this.child,
    this.backgroundColor,
  });

  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? fpduiTheme.card,
        borderRadius: BorderRadius.circular(fpduiTheme.radiusXl), // rounded-xl usually larger but we use theme radius
        border: Border.all(color: fpduiTheme.border),
        boxShadow: [
          BoxShadow(
            color: fpduiTheme.shadow,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

class FpduiCardHeader extends StatelessWidget {
  const FpduiCardHeader({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 0), // px-6 pt-6
      child: child,
    );
  }
}

class FpduiCardTitle extends StatelessWidget {
  const FpduiCardTitle({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTextStyle(
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.onSurface,
        height: 1.0,
        letterSpacing: -0.5,
      ) ?? const TextStyle(),
      child: child,
    );
  }
}

class FpduiCardDescription extends StatelessWidget {
  const FpduiCardDescription({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    
    return Padding(
      padding: const EdgeInsets.only(top: 6.0), // gap-2 approx
      child: DefaultTextStyle(
        style: theme.textTheme.bodyMedium?.copyWith(
          color: fpduiTheme.mutedForeground,
        ) ?? const TextStyle(),
        child: child,
      ),
    );
  }
}

class FpduiCardContent extends StatelessWidget {
  const FpduiCardContent({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24), // p-6 pt-0 usually, but shadcn uses p-6 in content and pt-0 if header exists
      // In flutter, composition is strict. Let's stick to simple padding.
      // shadcn: px-6 pt-0 (if header present logic is css based). 
      // Simplified: Just padding typical. users can override with padding widget if needed.
      // Actually shadcn uses `p-6 pt-0` often. Let's make it flexible.
      // Source says: `p-6 pt-0`
      child: child,
    );
  }
}

class FpduiCardFooter extends StatelessWidget {
  const FpduiCardFooter({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24), // p-6 pt-0 items-center
      child: child,
    );
  }
}
