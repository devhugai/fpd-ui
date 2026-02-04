import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../theme/fpdui_theme.dart';
import 'dialog.dart'; // For CommandDialog base

class FpduiCommand extends StatelessWidget {
  const FpduiCommand({
    super.key,
    required this.children,
    this.decoration,
  });

  final List<Widget> children;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Container(
      decoration: decoration ?? BoxDecoration(
        color: fpduiTheme.popover, 
        borderRadius: BorderRadius.circular(fpduiTheme.radius),
        border: Border.all(color: fpduiTheme.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

class FpduiCommandDialog extends StatelessWidget {
  const FpduiCommandDialog({
    super.key,
    required this.child,
    this.onClose,
  });

  final Widget child;
  final VoidCallback? onClose; // Usually handled by Navigator.pop

  static Future<T?> show<T>(BuildContext context, {required Widget child}) {
    return showDialog<T>(
      context: context,
      barrierColor: Colors.black54, // Overlay background
      builder: (context) => FpduiCommandDialog(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    // We reuse Dialog primitives or build custom to match shadcn CommandDialog (no header/footer usually, just the command)
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600), // Max width usually
        child: child, // The FpduiCommand
      ),
    );
  }
}

class FpduiCommandInput extends StatelessWidget {
  const FpduiCommandInput({
    super.key,
    this.placeholder = "Type a command or search...",
    this.onChanged,
    this.controller,
  });

  final String placeholder;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: fpduiTheme.border)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(LucideIcons.search, size: 18, color: theme.colorScheme.onBackground.withOpacity(0.5)),
          const Gap(8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.onBackground.withOpacity(0.5),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FpduiCommandList extends StatelessWidget {
  const FpduiCommandList({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 300), // Max height standard
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}

class FpduiCommandEmpty extends StatelessWidget {
  const FpduiCommandEmpty(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}

class FpduiCommandGroup extends StatelessWidget {
  const FpduiCommandGroup({
    super.key,
    required this.heading,
    required this.children,
  });

  final String heading;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            heading,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onBackground.withOpacity(0.6),
            ),
          ),
        ),
        ...children,
      ],
    );
  }
}

class FpduiCommandSeparator extends StatelessWidget {
  const FpduiCommandSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    return Container(
      height: 1,
      color: fpduiTheme.border,
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}

class FpduiCommandItem extends StatelessWidget {
  const FpduiCommandItem({
    super.key,
    required this.child,
    this.onSelect,
    this.selected = false, // In a real cmdk, this is managed by keyboard nav
    this.disabled = false,
  });

  final Widget child;
  final VoidCallback? onSelect;
  final bool selected;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return InkWell(
      onTap: disabled ? null : onSelect,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? fpduiTheme.accent : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: DefaultTextStyle.merge(
           style: TextStyle(
             fontSize: 14,
             color: selected ? fpduiTheme.accentForeground : theme.colorScheme.onBackground,
           ),
           child: IconTheme(
             data: IconThemeData(
               size: 16,
               color: selected ? fpduiTheme.accentForeground : theme.colorScheme.onBackground.withOpacity(0.7),
             ),
             child: child,
           ),
        ),
      ),
    );
  }
}

class FpduiCommandShortcut extends StatelessWidget {
  const FpduiCommandShortcut(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: theme.colorScheme.onBackground.withOpacity(0.5),
        letterSpacing: 0.5,
      ),
    );
  }
}
