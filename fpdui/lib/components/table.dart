/// Responsible for standard table layout.
/// Provides FpduiTable, TableHeader, TableRow, TableCell.
///
/// Used by: Data display, simple lists.
/// Depends on: fpdui_theme.
/// Assumes: HTML-like table structure composition.
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
    // final theme = Theme.of(context);
    // final fpduiTheme = theme.extension<FpduiTheme>()!;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: Table(
              columnWidths: columnWidths,
              defaultColumnWidth: defaultColumnWidth,
              border: border,
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: children,
            ),
          ),
        );
      },
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
    final fpduiTheme = theme?.extension<FpduiTheme>();
    final borderColor = fpduiTheme?.border ?? const Color(0xffd4d4d8); // fallback default

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
    final borderColor = fpduiTheme?.border ?? const Color(0xffd4d4d8);
    
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
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    return TableCell(
      child: Container(
        height: 48, // h-12
        padding: const EdgeInsets.symmetric(horizontal: 16), // px-4
        alignment: alignment,
        child: DefaultTextStyle(
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: fpduiTheme.mutedForeground,
          ) ?? const TextStyle(),
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
           style: Theme.of(context).textTheme.bodyMedium ?? const TextStyle(),
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
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        text,
        style: theme.textTheme.bodySmall?.copyWith(
          color: fpduiTheme.mutedForeground,
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
