// Responsible for displaying contextual content in a floating layer.
// Provides FpduiPopover and FpduiPopoverContent.
//
// Used by: Help tooltips (complex), small forms.
// Depends on: fpdui_theme.
// Assumes: Anchored to a trigger widget.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiPopover extends StatefulWidget {
  const FpduiPopover({
    super.key,
    required this.child,
    required this.content,
    this.controller,
    this.targetAnchor = Alignment.bottomCenter,
    this.followerAnchor = Alignment.topCenter,
    this.width,
    this.onOpenChange,
  });

  /// The widget that triggers the popover (e.g. Button).
  final Widget child;

  /// The content to display in the popover.
  final Widget content;

  final FpduiPopoverController? controller;
  final Alignment targetAnchor;
  final Alignment followerAnchor;
  final double? width;
  final ValueChanged<bool>? onOpenChange;

  @override
  State<FpduiPopover> createState() => _FpduiPopoverState();
}

class FpduiPopoverController {
  final MenuController _menuController = MenuController();
  
  void show() => _menuController.open();
  void hide() => _menuController.close();
  void toggle() {
    if (_menuController.isOpen) {
      _menuController.close();
    } else {
      _menuController.open();
    }
  }
}

class _FpduiPopoverState extends State<FpduiPopover> {
  late FpduiPopoverController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? FpduiPopoverController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return MenuAnchor(
      controller: _controller._menuController,
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(fpduiTheme.popover),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(fpduiTheme.radius),
              side: BorderSide(color: fpduiTheme.border),
          ),
        ),
        elevation: const WidgetStatePropertyAll(4),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(16)),
      ),
      menuChildren: [
        SizedBox(
          width: widget.width ?? 288,
          child: widget.content,
        ),
      ],
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
              widget.onOpenChange?.call(false);
            } else {
              controller.open();
              widget.onOpenChange?.call(true);
            }
          },
          child: widget.child,
        );
      },
    );
  }
}


