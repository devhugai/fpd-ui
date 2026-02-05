// Responsible for multi-line text input.
// Provides FpduiTextarea widget.
//
// Used by: Forms, comments, messages.
// Depends on: fpdui_theme.
// Assumes: Unlimited or constrained lines.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiTextarea extends StatelessWidget {
  const FpduiTextarea({
    super.key,
    this.controller,
    this.hintText,
    this.enabled = true,
    this.minLines = 3,
    this.maxLines,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? hintText;
  final bool enabled;
  final int? minLines;
  final int? maxLines;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return TextFormField(
      controller: controller,
      enabled: enabled,
      minLines: minLines,
      maxLines: maxLines, // null means unbounded (grow)
      onChanged: onChanged,
      textAlignVertical: TextAlignVertical.top, // Start text at top
      style: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w400,
        color: theme.colorScheme.onSurface,
      ),
      cursorColor: theme.colorScheme.primary,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w400,
          color: fpduiTheme.mutedForeground,
        ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(fpduiTheme.radius),
          borderSide: BorderSide(
            color: fpduiTheme.input,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(fpduiTheme.radius),
          borderSide: BorderSide(
            color: fpduiTheme.input,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(fpduiTheme.radius),
          borderSide: BorderSide(
            color: fpduiTheme.ring,
            width: 1.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(fpduiTheme.radius),
          borderSide: BorderSide(
            color: fpduiTheme.input.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
    );
  }
}
