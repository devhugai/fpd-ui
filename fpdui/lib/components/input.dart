// Responsible for text input fields.
// Provides FpduiInput widget.
//
// Used by: Forms, search bars.
// Depends on: fpdui_theme.
// Assumes: Handles text editing via controller.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiInput extends StatelessWidget {
  const FpduiInput({
    super.key,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.enabled = true,
    this.maxLines = 1,
    this.onChanged,
    this.validator,
    this.prefix,
    this.suffix,
  });

  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool enabled;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final Widget? prefix;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      enabled: enabled,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: validator,
      style: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w400,
        color: theme.colorScheme.onSurface,
      ),
      cursorColor: theme.colorScheme.primary, // caret-primary
      decoration: InputDecoration(
        prefixIcon: prefix != null
            ? IconTheme(
                data: IconThemeData(
                    color: fpduiTheme.mutedForeground, size: 16),
                child: prefix!)
            : null,
        suffixIcon: suffix != null
            ? IconTheme(
                data: IconThemeData(
                    color: fpduiTheme.mutedForeground, size: 16),
                child: suffix!)
            : null,
        hintText: hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: fpduiTheme.mutedForeground,
            ) ??
            const TextStyle(),
        filled: true,
        fillColor: Colors.transparent, // bg-transparent
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 8), // px-3 py-1 (h-9 approx)
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
            width: 1.5, // ring focus thickness
          ),
        ),
        // Disabled styling handled automatically by Flutter to some extent,
        // but we might want custom disabled border.
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(fpduiTheme.radius),
          borderSide: BorderSide(
            color: fpduiTheme.input.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(fpduiTheme.radius),
          borderSide: BorderSide(
            color: fpduiTheme.destructive,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(fpduiTheme.radius),
          borderSide: BorderSide(
            color: fpduiTheme.destructive,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
