/// Responsible for custom scrolling with styled scrollbars.
/// Provides FpduiScrollArea widget.
///
/// Used by: Long content lists, constrained containers.
/// Depends on: fpdui_theme.
/// Assumes: Wraps a scrollable or single child.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiScrollArea extends StatelessWidget {
  const FpduiScrollArea({
    super.key,
    required this.child,
    this.orientation = Axis.vertical,
    this.controller,
  });

  final Widget child;
  final Axis orientation;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    
    // Using ScrollConfiguration to force scrollbars if needed, 
    // but RawScrollbar is more explicit for styling.
    
    // We need a ScrollController to link Scrollbar and ScrollView if not provided.
    final ScrollController scrollController = controller ?? ScrollController();

    return RawScrollbar(
      controller: scrollController,
      thumbColor: fpduiTheme.border, // bg-border in shadcn
      radius: Radius.circular(fpduiTheme.radius),
      thickness: 10, // w-2.5 (10px) in shadcn
      thumbVisibility: true, // Always show? shadcn shows on hover or always depending on config. standard: hover/scroll. 
      // Flutter Default is fade. Let's stick to fade or always?
      // shadcn ScrollArea usually has visible scrollbar track?
      // shadcn source: "transition-colors select-none"
      // Let's use default behavior (fade) but styled thumb.
      trackVisibility: false, // shadcn doesn't usually show track bg unless configured.
      padding: EdgeInsets.zero,
      // Customizing track color if needed: trackColor: Colors.transparent
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: orientation,
        child: child,
      ),
    );
  }
}
