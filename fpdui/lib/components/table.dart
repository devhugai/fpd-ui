import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiTable extends StatelessWidget {
  const FpduiTable({
    super.key,
    required this.children,
    this.columnWidths,
    this.defaultColumnWidth = const FlexColumnWidth(),
    this.border,
  });

  final List<TableRow> children;
  final Map<int, TableColumnWidth>? columnWidths;
  final TableColumnWidth defaultColumnWidth;
  final TableBorder? border;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: MediaQuery.of(context).size.width, // Ensure full width or constraints?
        // Table behaves better if constrained or it shrinks.
        // Shadcn table is w-full.
        // In Flutter, Table expands to parent width.
        // If we put it in ScrollView, we need to constrain it to at LEAST screen width or allow intrinsic.
        // Let's use a Container with width constraint if needed, or let it handle itself.
        child: Table(
          columnWidths: columnWidths,
          defaultColumnWidth: defaultColumnWidth,
          border: border, // Shadcn usually borders on rows, handled via TableRow decoration logic or explicit border.
          // In React: [&_tr]:border-b
          // Flutter TableRow can have decoration.
          // But border collapse logic is tricky.
          // We'll try to emulate border-b via TableRow decoration.
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: children,
        ),
      ),
    );
  }
}

// Emulating helper for creating consistent rows
class FpduiTableRow {
  static TableRow header({
    required List<Widget> children,
    BoxDecoration? decoration,
    BuildContext? context,
  }) {
    // Header usually has border-b
    final theme = context != null ? Theme.of(context) : null;
    final borderColor = theme?.extension<FpduiTheme>()?.border ?? Colors.grey[300]!;

    return TableRow(
      decoration: decoration ?? BoxDecoration(
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      children: children,
    );
  }

  static TableRow row({
    required List<Widget> children,
    bool selected = false,
    BuildContext? context,
  }) {
    final theme = context != null ? Theme.of(context) : null;
    final fpduiTheme = theme?.extension<FpduiTheme>();
    final borderColor = fpduiTheme?.border ?? Colors.grey[300]!;
    
    // Logic for hover/selected bg would go here if we could.
    // data-[state=selected]:bg-muted
    
    return TableRow(
      decoration: BoxDecoration(
        color: selected ? fpduiTheme?.muted : null,
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      children: children,
    );
  }
}

class FpduiTableHead extends StatelessWidget {
  const FpduiTableHead({
    super.key,
    required this.child,
    this.alignment = Alignment.centerLeft,
  });

  final Widget child;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TableCell(
      child: Container(
        height: 48, // h-12
        padding: const EdgeInsets.symmetric(horizontal: 16), // px-4
        alignment: alignment,
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onBackground.withOpacity(0.6), // text-muted-foreground
          ),
          child: child,
        ),
      ),
    );
  }
}

class FpduiTableCell extends StatelessWidget {
  const FpduiTableCell({
    super.key,
    required this.child,
    this.alignment = Alignment.centerLeft,
  });

  final Widget child;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(16), // p-4
        alignment: alignment,
        child: DefaultTextStyle.merge(
           style: const TextStyle(fontSize: 14),
           child: child,
        ),
      ),
    );
  }
}

class FpduiTableCaption extends StatelessWidget {
  const FpduiTableCaption(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: theme.colorScheme.onBackground.withOpacity(0.6),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class FpduiTableFooter extends StatelessWidget {
  const FpduiTableFooter({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    
    // Usually a Row that mimics Table structure but is just a footer.
    // Or it can be a TableRow?
    // React implementation uses `tfoot`.
    // In Flutter Table, we can just add a row at the end with different styling.
    
    return Container(
      color: fpduiTheme.muted.withOpacity(0.5),
      child: Row(children: children), // Logic to match table columns is hard with just Row.
    );
  }
}
