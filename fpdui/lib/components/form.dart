import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../theme/fpdui_theme.dart';
import 'label.dart';

/// A wrapper for form fields that provides standard spacing and layout for
/// labels, input controls, descriptions, and error messages.
///
/// Corresponds to shadcn/ui's `FormItem`.
class FpduiFormItem extends StatelessWidget {
  const FpduiFormItem({
    super.key,
    required this.child,
    this.label,
    this.description,
    this.error,
    this.spacing = 8.0,
  });

  /// The input control (Input, Select, Checkbox, etc).
  final Widget child;

  /// Optional label text.
  final String? label;

  /// Optional helper text displayed below the input.
  final String? description;

  /// Optional error message. If present, replaces description or is shown below it (usually shadcn shows error instead or below).
  /// Shadcn logic: error makes label destructive color, and input border destructive.
  /// Here we just handle the layout of the message. The input border styling should be handled by the input itself based on error state.
  final String? error;

  /// Spacing between elements.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    // Determine label style based on error
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          FpduiLabel(
            label!,
            style: error != null 
              ? TextStyle(color: Theme.of(context).colorScheme.error)
              : null,
          ),
          Gap(spacing),
        ],
        child,
        if (description != null && error == null) ...[
          Gap(spacing),
          FpduiFormDescription(description!),
        ],
        if (error != null) ...[
          Gap(spacing),
          FpduiFormMessage(error!),
        ],
      ],
    );
  }
}

class FpduiFormDescription extends StatelessWidget {
  const FpduiFormDescription(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    
    return Text(
      text,
      style: TextStyle(
        fontSize: 13, // text-sm (14 max) or usually smaller for description? shadcn form-description is text-sm.
        color: fpduiTheme.mutedForeground,
      ),
    );
  }
}

class FpduiFormMessage extends StatelessWidget {
  const FpduiFormMessage(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Text(
      text,
      style: TextStyle(
        fontSize: 13, // text-sm
        fontWeight: FontWeight.w500,
        color: theme.colorScheme.error, // destructive
      ),
    );
  }
}
