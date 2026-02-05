/// Responsible for multi-line text input.
/// Provides FpduiTextarea widget.
///
/// Used by: Forms, comments, messages.
/// Depends on: fpdui_theme.
/// Assumes: Unlimited or constrained lines.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiTextarea extends StatefulWidget {
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
  State<FpduiTextarea> createState() => _FpduiTextareaState();
}

class _FpduiTextareaState extends State<FpduiTextarea> {
  late FocusNode _focusNode;
  
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
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
      enabled: widget.enabled,
      minLines: widget.minLines,
      maxLines: widget.maxLines, // null means unbounded (grow)
      onChanged: widget.onChanged,
      textAlignVertical: TextAlignVertical.top, // Start text at top
      style: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w400,
        color: theme.colorScheme.onBackground,
      ),
      cursorColor: theme.colorScheme.primary,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w400,
          color: fpduiTheme.mutedForeground,
        ) ?? const TextStyle(),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // px-3 py-2
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
            color: fpduiTheme.input.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
    );
  }
}
