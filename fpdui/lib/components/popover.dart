import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiPopover extends StatefulWidget {
  const FpduiPopover({
    super.key,
    required this.child,
    required this.content,
    this.controller,
  });

  /// The widget that triggers the popover (e.g. Button).
  final Widget child;

  /// The content to display in the popover.
  final Widget content;

  final FpduiPopoverController? controller;

  @override
  State<FpduiPopover> createState() => _FpduiPopoverState();
}

class _FpduiPopoverState extends State<FpduiPopover> {
  final LayerLink _layerLink = LayerLink();
  final OverlayPortalController _overlayController = OverlayPortalController();
  late FpduiPopoverController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? FpduiPopoverController();
    _controller._attach(this);
  }

  @override
  void dispose() {
    _controller._detach();
    super.dispose();
  }

  void _toggle() {
    _overlayController.toggle();
  }

  void _show() {
    _overlayController.show();
  }

  void _hide() {
    _overlayController.hide();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (context) {
          return Positioned(
            width: 300,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.bottomCenter,
              followerAnchor: Alignment.topCenter,
              offset: const Offset(0, 4),
              child: Align(
                alignment: Alignment.topCenter,
                child: TapRegion(
                  groupId: _layerLink, // Use layerLink as unique ID
                  onTapOutside: (event) => _hide(),
                  child: _PopoverContent(child: widget.content),
                ),
              ),
            ),
          );
        },
        child: TapRegion(
          groupId: _layerLink, // Same group ID
          child: GestureDetector(
            onTap: _toggle,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class FpduiPopoverController {
  _FpduiPopoverState? _state;

  void _attach(_FpduiPopoverState state) {
    _state = state;
  }

  void _detach() {
    _state = null;
  }

  void show() => _state?._show();
  void hide() => _state?._hide();
  void toggle() => _state?._toggle();
}

class _PopoverContent extends StatelessWidget {
  const _PopoverContent({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: 288, // w-72
        padding: const EdgeInsets.all(16), // p-4
        decoration: BoxDecoration(
          color: theme.colorScheme.background, // bg-popover
          borderRadius: BorderRadius.circular(fpduiTheme.radius), // rounded-md
          border: Border.all(color: fpduiTheme.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
