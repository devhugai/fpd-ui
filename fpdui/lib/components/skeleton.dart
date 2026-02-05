// Responsible for loading state placeholders.
// Provides FpduiSkeleton widget.
//
// Used by: Loading screens, async data fetching.
// Depends on: shimmer/animate effects, fpdui_theme.
// Assumes: Mimics shape of content being loaded.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiSkeleton extends StatefulWidget {
  const FpduiSkeleton({
    super.key,
    this.width,
    this.height,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
  });

  final double? width;
  final double? height;
  final BoxShape shape;
  final BorderRadiusGeometry? borderRadius;

  @override
  State<FpduiSkeleton> createState() => _FpduiSkeletonState();
}

class _FpduiSkeletonState extends State<FpduiSkeleton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: fpduiTheme.muted,
              shape: widget.shape,
              borderRadius: widget.shape == BoxShape.rectangle 
                  ? (widget.borderRadius ?? BorderRadius.circular(fpduiTheme.radius))
                  : null,
            ),
          ),
        );
      },
    );
  }
}
