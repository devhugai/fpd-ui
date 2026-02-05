/// Responsible for showing modal alerts to the user requiring action.
/// Provides FpduiAlertDialog, FpduiAlertDialogContent, etc.
///
/// Used by: Critical confirmations, warnings.
/// Depends on: fpdui_theme, button.dart.
/// Assumes: Triggered usually via showDialog or equivalent.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../theme/fpdui_theme.dart';
import 'button.dart';
import 'dialog.dart'; // Reuse dialog primitives or structure if possible, but AlertDialog is distinct semantic

// We can reuse FpduiDialogPrimitives technically, but to keep API clean we will recreate the structure 
// or aliasing is also an option if they are identical.
// In shadcn, AlertDialog has "AlertDialogAction" and "AlertDialogCancel" which are specific buttons.

class FpduiAlertDialog {
  /// Shows a shadcn-styled alert dialog.
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = false, // Alerts usually require explicit action
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => child,
    );
  }
}

class FpduiAlertDialogContent extends StatelessWidget {
  const FpduiAlertDialogContent({
    super.key,
    required this.child,
    this.maxWidth = 512,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    // Reusing FpduiDialogContent logic essentially, but without the X close button usually?
    // Shadcn AlertDialogContent does not show X close button in the example usually, it forces Action or Cancel.
    // Let's implement it without the close button by default or just reuse code.
    // I will duplicate logic to allow independent evolution and simpler API (no close button param needed).
    
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Dialog(
      backgroundColor: theme.colorScheme.background,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(fpduiTheme.radius),
        side: BorderSide(color: fpduiTheme.border),
      ),
      insetPadding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: child,
        ),
      ),
    );
  }
}

class FpduiAlertDialogHeader extends StatelessWidget {
  const FpduiAlertDialogHeader({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start, // sm:text-left
      children: [
        ...children,
        const Gap(16),
      ],
    );
  }
}

class FpduiAlertDialogTitle extends StatelessWidget {
  const FpduiAlertDialogTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.0,
      ),
    );
  }
}

class FpduiAlertDialogDescription extends StatelessWidget {
  const FpduiAlertDialogDescription(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: fpduiTheme.mutedForeground,
        ),
      ),
    );
  }
}

class FpduiAlertDialogFooter extends StatelessWidget {
  const FpduiAlertDialogFooter({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: children.map((e) => Padding(
          padding: EdgeInsets.only(left: children.indexOf(e) > 0 ? 8.0 : 0),
          child: e,
        )).toList(),
      ),
    );
  }
}

class FpduiAlertDialogAction extends StatelessWidget {
  const FpduiAlertDialogAction({
    super.key,
    required this.text,
    required this.onPressed,
    this.isDestructive = false, // Specific to alerts
  });

  final String text;
  final VoidCallback onPressed;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return FpduiButton(
      text: text,
      onPressed: onPressed,
      // If destructive, strictly usually we want `variant: destructive` but standard Action is often Primary (default).
      // If it's a "Delete" action in alert, user implies passing `variant: destructive`.
      // shadcn `AlertDialogAction` defaults to `variant="default"`.
      // I'll expose this just as a convenient button wrapper or let user use FpduiButton directly?
      // For semantic clarity, I'll use default variant.
      variant: FpduiButtonVariant.primary, 
    );
  }
}

class FpduiAlertDialogCancel extends StatelessWidget {
  const FpduiAlertDialogCancel({
    super.key,
    this.text = 'Cancel',
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FpduiButton(
      text: text,
      variant: FpduiButtonVariant.outline,
      onPressed: onPressed,
    );
  }
}
