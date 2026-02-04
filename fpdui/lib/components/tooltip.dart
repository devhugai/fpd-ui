import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/fpdui_theme.dart';

class FpduiTooltip extends StatefulWidget {
  const FpduiTooltip({
    super.key,
    required this.child,
    this.message,
    this.content,
    this.side = AxisDirection.up,
    this.waitDuration = const Duration(milliseconds: 500),
    this.showDuration = const Duration(milliseconds: 1500),
  }) : assert(message != null || content != null, 'Tooltip must have message or content');

  final Widget child;
  final String? message;
  final Widget? content;
  final AxisDirection side;
  final Duration waitDuration;
  final Duration showDuration;

  @override
  State<FpduiTooltip> createState() => _FpduiTooltipState();
}

class _FpduiTooltipState extends State<FpduiTooltip> {
  final OverlayPortalController _overlayController = OverlayPortalController();
  final LayerLink _layerLink = LayerLink();
  
  bool _isHovering = false;
  
  // Timer for wait duration
  Future<void>? _waitTimer;
  
  void _onEnter(PointerEvent event) {
    _isHovering = true;
    _startWaitTimer();
  }
  
  void _onExit(PointerEvent event) {
    _isHovering = false;
    _cancelWaitTimer();
    _hide();
  }

  void _startWaitTimer() {
    _waitTimer = Future.delayed(widget.waitDuration, () {
      if (mounted && _isHovering) {
        _show();
      }
    });
  }

  void _cancelWaitTimer() {
    // Dart Futures cannot be cancelled easily without a wrapper, 
    // but we check _isHovering flag in the callback.
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
      child: MouseRegion(
        onEnter: _onEnter,
        onExit: _onExit,
        child: GestureDetector(
          onLongPress: _show, // Mobile support
          onLongPressUp: _hide,
          child: OverlayPortal(
            controller: _overlayController,
            overlayChildBuilder: (context) {
              return Positioned(
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  // Primitive positioning logic - usually needs calculate layout.
                  // For simplicity we anchor center-top of target to center-bottom of tooltip (for AxisDirection.up)
                  targetAnchor: _getTargetAnchor(widget.side),
                  followerAnchor: _getFollowerAnchor(widget.side),
                  offset: _getOffset(widget.side),
                  child: _TooltipContent(
                    message: widget.message,
                    content: widget.content,
                    side: widget.side,
                  ).animate().fade(duration: 200.ms).scaleXY(begin: 0.95, end: 1.0, duration: 200.ms),
                ),
              );
            },
            child: widget.child,
          ),
        ),
      ),
    );
  }

  Alignment _getTargetAnchor(AxisDirection side) {
    switch (side) {
      case AxisDirection.up: return Alignment.topCenter;
      case AxisDirection.down: return Alignment.bottomCenter;
      case AxisDirection.left: return Alignment.centerLeft;
      case AxisDirection.right: return Alignment.centerRight;
    }
  }

  Alignment _getFollowerAnchor(AxisDirection side) {
    switch (side) {
      case AxisDirection.up: return Alignment.bottomCenter;
      case AxisDirection.down: return Alignment.topCenter;
      case AxisDirection.left: return Alignment.centerRight;
      case AxisDirection.right: return Alignment.centerLeft;
    }
  }

  Offset _getOffset(AxisDirection side) {
    const double gap = 8.0;
    switch (side) {
      case AxisDirection.up: return const Offset(0, -gap);
      case AxisDirection.down: return const Offset(0, gap);
      case AxisDirection.left: return const Offset(-gap, 0);
      case AxisDirection.right: return const Offset(gap, 0);
    }
  }
}

class _TooltipContent extends StatelessWidget {
  const _TooltipContent({
    this.message,
    this.content,
    required this.side,
  });

  final String? message;
  final Widget? content;
  final AxisDirection side;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return FractionallySizedBox(
        widthFactor: null, // Allow intrinsic width
        child: Container(
          mainAxisSize: MainAxisSize.min,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // px-3 py-1.5
          decoration: BoxDecoration(
            color: theme.colorScheme.onBackground, // bg-foreground (inverse)
            borderRadius: BorderRadius.circular(fpduiTheme.radius), // rounded-md
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              color: theme.colorScheme.background, // text-background (inverse)
              fontSize: 12, // text-xs
              fontWeight: FontWeight.w500,
            ),
            child: content ?? Text(message!),
          ),
        ),
    );
  }
}
