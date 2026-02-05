// Responsible for value selection from a range.
// Provides FpduiSlider widget.
//
// Used by: Settings, media controls.
// Depends on: fpdui_theme.
// Assumes: Range min/max and current value.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiSlider extends StatelessWidget {
  const FpduiSlider({
    super.key,
    required this.value,
    this.onChanged,
    this.min = 0.0,
    this.max = 100.0,
    this.divisions,
    this.enabled = true,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    // shadcn specs:
    // Track: h-1.5 (6px), bg-secondary (or muted). 
    //        "bg-primary absolute ... data-[orientation=horizontal]:h-full" -> Active track is primary.
    //        "bg-muted relative grow ... h-1.5" -> Inactive track is muted.
    // Thumb: size-4 (16px), border-primary, bg-background.
    //        Wait: "border-primary ring-offset-background block h-4 w-4 rounded-full border-2 bg-background ring-offset-2"
    //        Actually `slider.tsx` says: "border-primary ring-ring/50 block size-4 ... border bg-white"
    //        Let's interpret: Border is primary, Fill is background (white/kinda).
    
    // Flutter Slider is a bit tricky to style border on thumb.
    // We might need a custom thumb shape or just use a solid color for simplicity first.
    // Let's try to simulate border by using a larger thumb with a smaller inner circle? No.
    // Let's use `ThumbShape`.
    
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 6, // h-1.5 -> 6px
        activeTrackColor: theme.colorScheme.primary, // bg-primary
        inactiveTrackColor: fpduiTheme.muted, // bg-muted
        
        // Thumb
        thumbShape: _FpduiSliderThumbShape(
          thumbRadius: 8, // size-4 -> 16px diam -> 8px radius
          borderThickness: 1, // border-1
          shadowColor: fpduiTheme.shadow,
        ),
        thumbColor: theme.colorScheme.surface, // inner fill
        
        // Overlay (Focus ring/Hovers)
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
        overlayColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        
        // Track shape
        trackShape: const RoundedRectSliderTrackShape(),
        
        // Ticks
        tickMarkShape: const RoundSliderTickMarkShape(),
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
      ),
      child: Slider(
        value: value,
        onChanged: enabled ? onChanged : null,
        min: min,
        max: max,
        divisions: divisions,
      ),
    );
  }
}

class _FpduiSliderThumbShape extends SliderComponentShape {
  const _FpduiSliderThumbShape({
    required this.thumbRadius,
    required this.borderThickness,
    required this.shadowColor,
  });

  final double thumbRadius;
  final double borderThickness;
  final Color shadowColor;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint fillPaint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.white
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = sliderTheme.activeTrackColor ?? Colors.black // Active track is primary
      ..strokeWidth = borderThickness
      ..style = PaintingStyle.stroke;

    final Paint shadowPaint = Paint()
        ..color = shadowColor
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);

    // Shadow
    canvas.drawCircle(center.translate(0, 1), thumbRadius, shadowPaint);

    // Fill
    canvas.drawCircle(center, thumbRadius, fillPaint);

    // Border
    canvas.drawCircle(center, thumbRadius - (borderThickness / 2), borderPaint);
  }
}
