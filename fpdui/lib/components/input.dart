import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiInput extends StatefulWidget {
  const FpduiInput({
    super.key,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.enabled = true,
    this.maxLines = 1,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool enabled;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  @override
  State<FpduiInput> createState() => _FpduiInputState();
}

class _FpduiInputState extends State<FpduiInput> {
  late FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      onChanged: widget.onChanged,
      style: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w400,
        color: theme.colorScheme.onBackground,
      ),
      cursorColor: theme.colorScheme.primary, // caret-primary
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w400,
          color: fpduiTheme.mutedForeground,
        ) ?? const TextStyle(),
        filled: true,
        fillColor: Colors.transparent, // bg-transparent
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // px-3 py-1 (h-9 approx)
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
            color: fpduiTheme.input.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
    );
  }
}
