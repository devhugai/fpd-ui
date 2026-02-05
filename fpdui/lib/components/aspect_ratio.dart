/// Responsible for displaying content within a desired ratio.
/// Provides FpduiAspectRatio widget.
///
/// Used by: Images, video players, maps.
/// Depends on: flutter/material.
import 'package:flutter/material.dart';

class FpduiAspectRatio extends StatelessWidget {
  const FpduiAspectRatio({
    super.key,
    required this.ratio,
    required this.child,
  });

  /// The aspect ratio to attempt to use.
  ///
  /// The aspect ratio is expressed as a ratio of width to height. For example, a
  /// 16:9 width:height aspect ratio would have a value of 16.0 / 9.0.
  final double ratio;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: ratio,
      child: child,
    );
  }
}
