import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';

class FpduiDialog {
  /// Shows a shadcn-styled dialog.
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => child,
    );
  }
}

class FpduiDialogContent extends StatelessWidget {
  const FpduiDialogContent({
    super.key,
    required this.child,
    this.maxWidth = 512, // sm:max-w-lg (32rem = 512px)
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Dialog(
      backgroundColor: theme.colorScheme.background,
      surfaceTintColor: Colors.transparent, // Remove M3 tint
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(fpduiTheme.radiusLg),
        side: BorderSide(color: fpduiTheme.border),
      ),
      insetPadding: const EdgeInsets.all(24), // margin for small screens
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: const EdgeInsets.all(24), // p-6
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              child,
              Positioned( // Close button (X)
                right: -8, // Adjustment for padding
                top: -8,
                child: IconButton(
                  icon: Icon(LucideIcons.x, size: 16, color: fpduiTheme.mutedForeground),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  style: IconButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    hoverColor: fpduiTheme.accent,
                    highlightColor: fpduiTheme.accent.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FpduiDialogHeader extends StatelessWidget {
  const FpduiDialogHeader({
    super.key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.start, // sm:text-left (default)
  });

  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        ...children,
        const Gap(16), // gap-4 between header and content usually?
        // Wait, source says: "grid w-full ... gap-4". The gap-4 is the main grid gap.
        // The header itself has "flex flex-col gap-2".
        // Let's assume the user puts Header then Content then Footer.
        // We should probably just provide the spacing in the Header itself:
      ],
    );
  }
}

class FpduiDialogTitle extends StatelessWidget {
  const FpduiDialogTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600, // font-semibold
        height: 1.0, // leading-none
      ) ?? const TextStyle(),
    );
  }
}

class FpduiDialogDescription extends StatelessWidget {
  const FpduiDialogDescription(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0), // gap-2 inside header
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: fpduiTheme.mutedForeground,
        ) ?? const TextStyle(),
      ),
    );
  }
}

class FpduiDialogFooter extends StatelessWidget {
  const FpduiDialogFooter({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end, // sm:justify-end
        children: children.map((e) => Padding(
          padding: EdgeInsets.only(left: children.indexOf(e) > 0 ? 8.0 : 0), // gap-2
          child: e,
        )).toList(),
      ),
    );
  }
}
