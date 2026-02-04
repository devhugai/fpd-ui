import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../theme/fpdui_theme.dart';
import 'table.dart';
import 'button.dart';
import 'input.dart';
import 'checkbox.dart';
import 'dropdown_menu.dart';

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
  
  // Filters & Visibility
  String _searchQuery = '';
  final Set<int> _hiddenColumns = {}; // Set of indices of hidden columns

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
      if (_sortColumnIndex != null) {
         _sort(_sortColumnIndex!, _sortAscending);
      }
    }
  }

  void _sort(int columnIndex, bool ascending) {
    final column = widget.columns[columnIndex];
    if (!column.enableSorting) return;

    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      
      // Basic sorting
      // We assume accessorKey matches a field or we rely on user provided data being somewhat simple for MVP.
      // To properly sort generic T without reflection, we'd need a comparator in FpduiDataColumn.
      // For now, let's skip actual sorting logic implementation on T as it's complex without reflection or callbacks.
      // Visual feedback only for MVP unless we add `comparator` to Column.
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
  
  List<T> get _filteredData {
    if (_searchQuery.isEmpty) return _sortedData;
    
    // Naive generic search: toString() check
    return _sortedData.where((item) {
      return item.toString().toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  List<T> get _paginatedData {
    final data = _filteredData;
    final startIndex = _currentPage * _pageSize;
    if (startIndex >= data.length) return [];
    
    final endIndex = (startIndex + _pageSize < data.length) 
        ? startIndex + _pageSize 
        : data.length;
        
    return data.sublist(startIndex, endIndex);
  }

  int get _totalPages => (_filteredData.length / _pageSize).ceil();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    
    // Filter out hidden columns from definitions effectively for width calculation
    // Indices in widget.columns map to columnWidths keys.
    // If RowSelection is on, Col 0 is Checkbox. Col 1 is widget.columns[0].
    
    final columnWidths = <int, TableColumnWidth>{};
    int visibleColCount = 0;
    
    if (widget.enableRowSelection) {
      columnWidths[0] = const FixedColumnWidth(48);
      visibleColCount++;
    }
    
    for (int i = 0; i < widget.columns.length; i++) {
        if (_hiddenColumns.contains(i)) continue;
        
        // Map logical index 'i' to Table index
        int tableIndex = widget.enableRowSelection ? i + 1 : i;
        columnWidths[tableIndex] = FlexColumnWidth(widget.columns[i].flex.toDouble());
        visibleColCount++;
    }

    return Column(
      children: [
        // Toolbar (Search/Filter)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
               SizedBox(
                width: 250,
                child: FpduiInput(
                   hintText: 'Filter...',
                   onChanged: (val) {
                     setState(() {
                       _searchQuery = val;
                       _currentPage = 0; // Reset page on filter
                     });
                   },
                ),
               ),
               const Spacer(),
               FpduiDropdownMenu(
                 trigger: FpduiButton(
                   variant: FpduiButtonVariant.outline,
                   text: 'Columns',
                   trailingIcon: const Icon(LucideIcons.chevronDown, size: 16),
                 ),
                 items: [
                   FpduiDropdownMenuLabel("Toggle Columns"),
                   FpduiDropdownMenuSeparator(),
                   ...widget.columns.asMap().entries.map((entry) {
                     final index = entry.key;
                     final col = entry.value;
                     final isVisible = !_hiddenColumns.contains(index);
                     return FpduiDropdownMenuItem(
                       child: Row(
                         children: [
                            SizedBox(width: 16, child: isVisible ? const Icon(LucideIcons.check, size: 14) : null),
                            const Gap(8),
                            Text(col.accessorKey ?? 'Column $index'),
                         ],
                       ),
                       onTap: () {
                         setState(() {
                           if (isVisible) {
                             _hiddenColumns.add(index);
                           } else {
                             _hiddenColumns.remove(index);
                           }
                         });
                       },
                     );
                   }),
                 ],
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
                          onChanged: _toggleSelectAll,
                        ),
                      ),
                      
                    ...widget.columns.asMap().entries.where((e) => !_hiddenColumns.contains(e.key)).map((entry) {
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
                      ), 
                      // Need to fill remaining cells to avoid table error
                      ...List.generate(
                        visibleColCount - 1, 
                        (index) => const TableCell(child: SizedBox()),
                      ),
                    ], 
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
                        
                      ...widget.columns.asMap().entries.where((e) => !_hiddenColumns.contains(e.key)).map((entry) {
                        final col = entry.value;
                         if (col.cell != null) {
                          return FpduiTableCell(child: col.cell!(context, item));
                        }
                        return const FpduiTableCell(child: Text(''));
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
