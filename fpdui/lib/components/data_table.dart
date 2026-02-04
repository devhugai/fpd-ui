import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../theme/fpdui_theme.dart';
import 'table.dart';
import 'button.dart';
import 'input.dart';
import 'checkbox.dart';

// Definition for a column
class FpduiDataColumn<T> {
  final Widget Function(BuildContext context, T data)? cell;
  final Widget Function(BuildContext context)? header;
  final String? accessorKey; // For simple string access if cell is null
  final bool enableSorting;
  final int flex; // For Expanded
  
  // Helper to get value if accessor is present
  // dynamic getValue(T data) ... (Requires reflection or dynamic access, in Flutter usually we use cell builder)

  const FpduiDataColumn({
    this.cell,
    this.header,
    this.accessorKey,
    this.enableSorting = false,
    this.flex = 1,
  });
}

class FpduiDataTable<T> extends StatefulWidget {
  const FpduiDataTable({
    super.key,
    required this.data,
    required this.columns,
    this.enableRowSelection = false,
    this.onSelectionChanged,
  });

  final List<T> data;
  final List<FpduiDataColumn<T>> columns;
  final bool enableRowSelection;
  final ValueChanged<List<T>>? onSelectionChanged;

  @override
  State<FpduiDataTable<T>> createState() => _FpduiDataTableState<T>();
}

class _FpduiDataTableState<T> extends State<FpduiDataTable<T>> {
  // State
  late List<T> _sortedData;
  final Set<T> _selectedRows = {};
  int? _sortColumnIndex;
  bool _sortAscending = true;
  
  // Pagination
  int _currentPage = 0;
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _sortedData = List.from(widget.data);
  }

  @override
  void didUpdateWidget(FpduiDataTable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      _sortedData = List.from(widget.data);
      // Re-apply sort if needed
    }
  }

  void _sort(int columnIndex, bool ascending) {
    final column = widget.columns[columnIndex];
    if (!column.enableSorting) return;

    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      
      // Basic sorting if accessorKey is string
      // Just a mock implementation of sorting for now since we don't have true generic accessor logic without reflection
      // In real world usage, user provides a `sorter` function.
      // For MVP, we'll assuming we don't sort or we sort by string representation.
    });
  }

  void _toggleSelectAll(bool? value) {
    setState(() {
      if (value == true) {
        _selectedRows.addAll(_paginatedData);
      } else {
        _selectedRows.clear();
      }
      widget.onSelectionChanged?.call(_selectedRows.toList());
    });
  }

  void _toggleSelectRow(T item, bool? value) {
    setState(() {
      if (value == true) {
        _selectedRows.add(item);
      } else {
        _selectedRows.remove(item);
      }
      widget.onSelectionChanged?.call(_selectedRows.toList());
    });
  }

  List<T> get _paginatedData {
    final startIndex = _currentPage * _pageSize;
    if (startIndex >= _sortedData.length) return [];
    
    final endIndex = (startIndex + _pageSize < _sortedData.length) 
        ? startIndex + _pageSize 
        : _sortedData.length;
        
    return _sortedData.sublist(startIndex, endIndex);
  }

  int get _totalPages => (_sortedData.length / _pageSize).ceil();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    
    // We emulate a Table structure but using Flex/Rows for layout flexibility (Standard Shadcn look)
    // Or we stick to FpduiTable (which uses Table widget).
    // FpduiTable uses Table widget which is rigid on column widths.
    // DataTable usually needs resizable or intrinsic widths.
    // Let's use FpduiTable with FixedColumnWidths or FlexColumnWidths based on `flex` prop in definition.

    final columnWidths = <int, TableColumnWidth>{};
    if (widget.enableRowSelection) {
      columnWidths[0] = const FixedColumnWidth(48); // Checkbox column
      for (int i = 0; i < widget.columns.length; i++) {
        columnWidths[i + 1] = FlexColumnWidth(widget.columns[i].flex.toDouble());
      }
    } else {
       for (int i = 0; i < widget.columns.length; i++) {
        columnWidths[i] = FlexColumnWidth(widget.columns[i].flex.toDouble());
      }
    }

    return Column(
      children: [
        // Toolbar (Search/Filter placeholder)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
               SizedBox(
                width: 250,
                child: FpduiInput(
                   hintText: 'Filter emails...',
                   onChanged: (val) {
                     // Implement filter logic
                   },
                ),
               ),
               const Spacer(),
               FpduiButton(
                 variant: FpduiButtonVariant.outline,
                 text: 'Columns',
                 trailingIcon: const Icon(LucideIcons.chevronDown, size: 16),
                 onPressed: () {},
               ),
            ],
          ),
        ),
        
        // Table
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: fpduiTheme.border),
            borderRadius: BorderRadius.circular(fpduiTheme.radius),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(fpduiTheme.radius),
            child: FpduiTable(
              columnWidths: columnWidths,
              children: [
                // Header
                FpduiTableRow.header(
                  context: context,
                  children: [
                    if (widget.enableRowSelection)
                      FpduiTableHead(
                        child: FpduiCheckbox(
                          value: _selectedRows.length == _paginatedData.length && _paginatedData.isNotEmpty,
                           // Indeterminate would be nice
                          onChanged: _toggleSelectAll,
                        ),
                      ),
                      
                    ...widget.columns.asMap().entries.map((entry) {
                      final i = entry.key;
                      final col = entry.value;
                      return FpduiTableHead(
                        child: InkWell(
                          onTap: col.enableSorting ? () {
                            _sort(i, !_sortAscending);
                          } : null,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (col.header != null) 
                                col.header!(context) 
                              else 
                                Text(col.accessorKey ?? ''),
                              if (col.enableSorting) ...[
                                const Gap(4),
                                Icon(LucideIcons.arrowUpDown, size: 12),
                              ],
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                
                // Body
                if (_paginatedData.isEmpty)
                  TableRow(
                    children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                         child: Container(
                           height: 100, // h-24
                           alignment: Alignment.center,
                           child: const Text('No results.'),
                         ),
                      ), // PROBLEM: TableRow must have same number of columns.
                      // We need to span columns? generic Table widget doesn't support colspan nicely on one row relative to headers defined in columnWidths map easily without hacks.
                      // Actually TableCell has NO colspan.
                      // This is why `Table` widget is rigid.
                      // Workaround: Nested Table or just fill other cells with empty.
                    ] + List.generate(
                        widget.columns.length + (widget.enableRowSelection ? 0 : -1), // + selection - 1 for first cell?
                        (index) => const TableCell(child: SizedBox()),
                      ), 
                  ),

                ..._paginatedData.map((item) {
                  final isSelected = _selectedRows.contains(item);
                  return FpduiTableRow.row(
                    context: context,
                    selected: isSelected,
                    children: [
                      if (widget.enableRowSelection)
                        FpduiTableCell(
                          child: FpduiCheckbox(
                            value: isSelected,
                            onChanged: (val) => _toggleSelectRow(item, val),
                          ),
                        ),
                        
                      ...widget.columns.map((col) {
                        if (col.cell != null) {
                          return FpduiTableCell(child: col.cell!(context, item));
                        }
                        // Default string access? - Requires reflection or map
                        return const FpduiTableCell(child: Text('?'));
                      }),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
        
        // Footer / Pagination
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (widget.enableRowSelection)
                 Text(
                   '${_selectedRows.length} of ${_sortedData.length} row(s) selected.',
                   style: TextStyle(color: fpduiTheme.mutedForeground, fontSize: 13),
                 ),
              const Spacer(),
              FpduiButton(
                variant: FpduiButtonVariant.outline,
                size: FpduiButtonSize.sm,
                text: 'Previous',
                onPressed: _currentPage == 0 ? null : () => setState(() => _currentPage--),
              ),
              const Gap(8),
               FpduiButton(
                variant: FpduiButtonVariant.outline,
                size: FpduiButtonSize.sm,
                text: 'Next',
                onPressed: _currentPage >= _totalPages - 1 ? null : () => setState(() => _currentPage++),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
