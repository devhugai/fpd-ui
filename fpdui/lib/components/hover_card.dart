// Responsible for displaying interactive content on hover.
// Provides FpduiHoverCard widget.
//
// Used by: User profiles, product previews.
// Depends on: fpdui_theme.
// Assumes: Mouse environment (Hover).
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/fpdui_theme.dart';

class FpduiHoverCard extends StatefulWidget {
  const FpduiHoverCard({
    super.key,
    required this.trigger,
    required this.content,
    this.side = AxisDirection.up,
    this.openDelay = const Duration(milliseconds: 200),
    this.closeDelay = const Duration(milliseconds: 300),
    this.width = 300,
  });

  final Widget trigger;
  final Widget content;
  final AxisDirection side;
  final Duration openDelay;
  final Duration closeDelay;
  final double width;

  @override
  State<FpduiHoverCard> createState() => _FpduiHoverCardState();
}

class _FpduiHoverCardState extends State<FpduiHoverCard> {
  final OverlayPortalController _overlayController = OverlayPortalController();
  final LayerLink _layerLink = LayerLink();
  
  Timer? _openTimer;
  Timer? _closeTimer;
  
  bool _isHoveringTrigger = false;
  bool _isHoveringContent = false;

  void _handleTriggerEnter(PointerEvent _) {
    _isHoveringTrigger = true;
    _scheduleOpen();
  }

  void _handleTriggerExit(PointerEvent _) {
    _isHoveringTrigger = false;
    _scheduleClose();
  }

  void _handleContentEnter(PointerEvent _) {
    _isHoveringContent = true;
    // If we entered content, cancel any close timer from trigger exit
    _closeTimer?.cancel();
  }
  
  void _handleContentExit(PointerEvent _) {
    _isHoveringContent = false;
    _scheduleClose();
  }

  void _scheduleOpen() {
    _closeTimer?.cancel(); // Cancel closing if we re-entered
    if (_overlayController.isShowing) return;

    _openTimer?.cancel();
    _openTimer = Timer(widget.openDelay, () {
      if (mounted && _isHoveringTrigger) {
        _overlayController.show();
      }
    });
  }

  void _scheduleClose() {
    _openTimer?.cancel();
    _closeTimer?.cancel();
    
    _closeTimer = Timer(widget.closeDelay, () {
      if (mounted && !_isHoveringTrigger && !_isHoveringContent) {
        _overlayController.hide();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: _handleTriggerEnter,
        onExit: _handleTriggerExit,
        // Also support tap for mobile? Usually hover card is desktop pattern.
        // For mobile, this might behave like a Popover (tap to toggle).
        child: GestureDetector(
          onTap: () {
             if (_overlayController.isShowing) {
               _overlayController.hide();
             } else {
               _overlayController.show();
             }
          },
          child: OverlayPortal(
            controller: _overlayController,
            overlayChildBuilder: (context) {
              return Align(
                 alignment: Alignment.topLeft,
                 child: CompositedTransformFollower(
                  link: _layerLink,
                  targetAnchor: _getTargetAnchor(widget.side),
                  followerAnchor: _getFollowerAnchor(widget.side),
                  offset: _getOffset(widget.side),
                  child: MouseRegion(
                    onEnter: _handleContentEnter,
                    onExit: _handleContentExit,
                    child: _HoverCardContent(
                      width: widget.width,
                      content: widget.content,
                      side: widget.side,
                    ).animate().fade(duration: 200.ms).scaleXY(begin: 0.95, end: 1.0, duration: 200.ms),
                  ),
                 ),
              );
            },
            child: widget.trigger,
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

class _HoverCardContent extends StatelessWidget {
  const _HoverCardContent({
    required this.width,
    required this.content,
    required this.side,
  });

  final double width;
  final Widget content;
  final AxisDirection side;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(fpduiTheme.radius),
        border: Border.all(color: fpduiTheme.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: content,
    );
  }
}
