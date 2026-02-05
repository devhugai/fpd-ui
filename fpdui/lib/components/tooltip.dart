// Responsible for displaying helper text on hover.
// Provides FpduiTooltip widget.
//
// Used by: Icon buttons, dense UIs.
// Depends on: fpdui_theme.
// Assumes: Triggered on hover/long-press.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiTooltip extends StatelessWidget {
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
  final Widget? content; // Tooltip currently only supports richMessage (InlineSpan) or string message. 
                         // Native Tooltip doesn't support arbitrary widget content easily without `richMessage` hack or just sticking to text.
                         // However, for FPDUI parity, if valid `content` widget is passed that isn't text, we might need a workaround or just support text.
                         // But `Tooltip` in Flutter supports `richMessage`.
                         // If `content` is provided, we should probably stick to `message` if possible or warn. 
                         // Actually, let's keep it simple: Map message to message. If content is supplied we try to use it if it's text, or ignore/warn.
                         // WAIT: `Tooltip` supports `richMessage` which takes an `InlineSpan`.
                         // If `content` passed is intricate, native Tooltip might be limited.
                         // But the instruction is to use native components. 
                         // Let's implement using `message`.
  final AxisDirection side;
  final Duration waitDuration;
  final Duration showDuration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Tooltip(
      message: message ?? '',
      richMessage: content is Text 
          ? TextSpan(text: (content as Text).data, style: (content as Text).style) 
          : null, // Simplified mapping. Real arbitrary widget content isn't fully supported by native Tooltip cleanly.
      waitDuration: waitDuration,
      showDuration: showDuration,
      preferBelow: side == AxisDirection.down,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: const EdgeInsets.all(8),
      verticalOffset: 12, // Gap approximation
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface,
        borderRadius: BorderRadius.circular(fpduiTheme.radius),
      ),
      textStyle: theme.textTheme.labelSmall?.copyWith(
        color: theme.colorScheme.surface,
        fontWeight: FontWeight.w500,
      ),
      child: child,
    );
  }
}
