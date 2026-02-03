import 'package:flutter/material.dart';

class FpduiLabel extends StatelessWidget {
  const FpduiLabel(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.required = false,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // shadcn/ui label specs:
    // text-sm (14px)
    // font-medium (w500)
    // leading-none (height: 1.0)
    // peer-disabled:cursor-not-allowed peer-disabled:opacity-70 (handled by parent/form usually)

    final baseStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: theme.colorScheme.onBackground,
      height: 1.0, 
    );

    Widget labelText = Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: baseStyle.merge(style),
    );

    if (required) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          labelText,
          const Text(
            ' *',
            style: TextStyle(color: Colors.red), 
          ),
        ],
      );
    }

    return labelText;
  }
}
