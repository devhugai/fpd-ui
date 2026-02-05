/// Responsible for displaying navigation path hierarchy.
/// Provides FpduiBreadcrumb and FpduiBreadcrumbItem widgets.
///
/// Used by: Deeply nested pages, file browsers.
/// Depends on: fpdui_theme, lucide_icons.
/// Assumes: Ordered list of navigation steps.
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../theme/fpdui_theme.dart';

class FpduiBreadcrumb extends StatelessWidget {
  const FpduiBreadcrumb({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class FpduiBreadcrumbList extends StatelessWidget {
  const FpduiBreadcrumbList({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8, // gap-2 sm:gap-2.5
      runSpacing: 4,
      children: children,
    );
  }
}

class FpduiBreadcrumbItem extends StatelessWidget {
  const FpduiBreadcrumbItem({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [child],
    );
  }
}

class FpduiBreadcrumbLink extends StatelessWidget {
  const FpduiBreadcrumbLink({
    super.key,
    required this.child,
    this.onTap,
    this.asChild = false,
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool asChild;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Breadcrumb Link Style: text-muted-foreground hover:text-foreground
    // If we want hover effect, we ideally use a centralized Hover builder or InkWell.
    // Given current scope, InkWell with opacity/color change.
    
    // Shadcn uses transition-colors.
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      hoverColor: Colors.transparent, // We want text color change, not bg.
      // Implementing text color change on hover is tricky without StatefulWidget or MouseRegion wrapper affecting state.
      // Quickest way: Use MouseRegion + State or just simple InkWell which gives ripple.
      // Shadcn is ripple-free usually on links.
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: DefaultTextStyle.merge(
           style: TextStyle(
             fontSize: 14,
             color: theme.colorScheme.onBackground.withOpacity(0.6), // muted-foreground
             // We can't easily animate text color here without state.
             // For now, static mute.
           ),
           child: child, // Ideally wrapped in HoverBuilder to switch color to onBackground.
        ),
      ),
    );
  }
}

// Stateful version for Hover effect if desired
class FpduiBreadcrumbLinkInteractive extends StatefulWidget {
  const FpduiBreadcrumbLinkInteractive({super.key, required this.child, this.onTap});
  final Widget child;
  final VoidCallback? onTap;

  @override
  State<FpduiBreadcrumbLinkInteractive> createState() => _FpduiBreadcrumbLinkInteractiveState();
}

class _FpduiBreadcrumbLinkInteractiveState extends State<FpduiBreadcrumbLinkInteractive> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _isHovered 
        ? theme.colorScheme.onBackground 
        : theme.colorScheme.onBackground.withOpacity(0.6);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: color,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}


class FpduiBreadcrumbPage extends StatelessWidget {
  const FpduiBreadcrumbPage({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTextStyle.merge(
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: theme.colorScheme.onBackground, // foreground
      ),
      child: child,
    );
  }
}

class FpduiBreadcrumbSeparator extends StatelessWidget {
  const FpduiBreadcrumbSeparator({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IconTheme(
      data: IconThemeData(
        size: 14, 
        color: theme.colorScheme.onBackground.withOpacity(0.6),
      ),
      child: child ?? const Icon(LucideIcons.chevronRight),
    );
  }
}

class FpduiBreadcrumbEllipsis extends StatelessWidget {
  const FpduiBreadcrumbEllipsis({super.key});

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Icon(
      LucideIcons.moreHorizontal,
      size: 16,
      color: theme.colorScheme.onBackground.withOpacity(0.6),
    );
  }
}
