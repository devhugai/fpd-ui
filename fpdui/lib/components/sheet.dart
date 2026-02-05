// Responsible for displaying side drawers or modal sheets.
// Provides FpduiSheet, SheetContent, etc.
//
// Used by: Mobile navigation, detailed forms in drawers.
// Depends on: fpdui_theme.
// Assumes: Slides in from edge.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';

enum FpduiSheetSide { top, right, bottom, left }

class FpduiSheet extends StatefulWidget {
  const FpduiSheet({
    super.key,
    required this.open,
    this.onOpenChange,
    required this.content,
    this.side = FpduiSheetSide.right,
  });

  final bool open;
  final ValueChanged<bool>? onOpenChange;
  final Widget content;
  final FpduiSheetSide side;

  /// Imperative show method
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    FpduiSheetSide side = FpduiSheetSide.right,
    bool barrierDismissible = true,
  }) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: 'Dismiss',
      barrierColor: fpduiTheme.overlay,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: _getAlignment(side),
          child: Material(
            color: Colors.transparent,
            child: _FpduiSheetContainer(
              side: side,
              child: child,
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final offsetTween = _getSlideTween(side);
        return SlideTransition(
          position: animation.drive(offsetTween),
          child: FadeTransition(
              opacity: animation,
              child: child,
          ),
        );
      },
    );
  }

  static Alignment _getAlignment(FpduiSheetSide side) {
    switch (side) {
      case FpduiSheetSide.top: return Alignment.topCenter;
      case FpduiSheetSide.bottom: return Alignment.bottomCenter;
      case FpduiSheetSide.left: return Alignment.centerLeft;
      case FpduiSheetSide.right: return Alignment.centerRight;
    }
  }

  static Tween<Offset> _getSlideTween(FpduiSheetSide side) {
    switch (side) {
      case FpduiSheetSide.top:
        return Tween(begin: const Offset(0, -1), end: Offset.zero);
      case FpduiSheetSide.bottom:
        return Tween(begin: const Offset(0, 1), end: Offset.zero);
      case FpduiSheetSide.left:
        return Tween(begin: const Offset(-1, 0), end: Offset.zero);
      case FpduiSheetSide.right:
        return Tween(begin: const Offset(1, 0), end: Offset.zero);
    }
  }

  @override
  State<FpduiSheet> createState() => _FpduiSheetState();
}

class _FpduiSheetState extends State<FpduiSheet> {
  bool _isShown = false;

  @override
  void didUpdateWidget(FpduiSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.open != oldWidget.open) {
      if (widget.open && !_isShown) {
        _show();
      } else if (!widget.open && _isShown) {
        // Can't easily force pop specific route without ref, but usually user dismisses it.
        // If programmatic close is needed:
        Navigator.of(context).pop(); 
      }
    }
  }

  void _show() {
    _isShown = true;
    FpduiSheet.show(
      context: context,
      child: widget.content,
      side: widget.side,
    ).then((_) {
      _isShown = false;
      widget.onOpenChange?.call(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // This widget is logical only
  }
}

class _FpduiSheetContainer extends StatelessWidget {
  const _FpduiSheetContainer({
    required this.side,
    required this.child,
  });

  final FpduiSheetSide side;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    // Determine constraints/decoration strictly based on shadcn
    // Side Right/Left: h-full w-3/4 sm:max-w-sm (approx 384px)
    // Side Top/Bottom: h-auto inset-x-0
    
    double? width;
    double? height;
    
    if (side == FpduiSheetSide.left || side == FpduiSheetSide.right) {
      width = 340; // sm:max-w-sm approx.
      height = double.infinity;
    } else {
      width = double.infinity;
      height = null; // Auto
    }

    return Container(
      width: width,
      height: height,
      color: theme.colorScheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min, // For top/bottom to auto-size
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            // Close Button usually absolute positioned. 
            // We can put it in a Stack or just part of Header.
            // Shadcn puts it absolute top-4 right-4.
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24), // p-6
                  child: child,
                ),
                 Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(LucideIcons.x, size: 16, color: fpduiTheme.mutedForeground),
                    onPressed: () => Navigator.of(context).pop(),
                    style: IconButton.styleFrom(
                       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class FpduiSheetContent extends StatelessWidget {
  const FpduiSheetContent({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => child;
}

class FpduiSheetHeader extends StatelessWidget {
  const FpduiSheetHeader({super.key, required this.children});
  final List<Widget> children;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...children,
        const Gap(24),
      ],
    );
  }
}

class FpduiSheetTitle extends StatelessWidget {
  const FpduiSheetTitle(this.text, {super.key});
  final String text;
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        height: 1.0,
      ),
    );
  }
}

class FpduiSheetDescription extends StatelessWidget {
  const FpduiSheetDescription(this.text, {super.key});
  final String text;
  
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: fpduiTheme.mutedForeground,
        ),
      ),
    );
  }
}

class FpduiSheetFooter extends StatelessWidget {
  const FpduiSheetFooter({super.key, required this.children});
  final List<Widget> children;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column( // Flex-col-reverse on mobile, usually row on larger. Let's stack for safety on side sheets.
         crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children.map((e) => Padding(
          padding: EdgeInsets.only(top: children.indexOf(e) > 0 ? 8.0 : 0),
          child: e,
        )).toList(),
      ),
    );
  }
}
