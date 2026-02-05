/// Responsible for displaying documentation for Table component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: table.dart, component_page.
import 'package:flutter/material.dart';
import '../../components/table.dart';
import '../../components/card.dart';

class TablePage extends StatelessWidget {
  const TablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Table')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const FpduiCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FpduiCardHeader(child: FpduiCardTitle(child: Text('Invoices'))),
                  FpduiCardContent(child: _TableExample()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TableExample extends StatelessWidget {
  const _TableExample();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FpduiTable(
          children: [
            FpduiTableRow.header(
              context: context,
              children: const [
                FpduiTableHead(child: Text('Invoice')),
                FpduiTableHead(child: Text('Status')),
                FpduiTableHead(child: Text('Method')),
                FpduiTableHead(child: Text('Amount'), alignment: Alignment.centerRight),
              ],
            ),
            FpduiTableRow.row(
              context: context,
              children: const [
                FpduiTableCell(child: Text('INV001')),
                FpduiTableCell(child: Text('Paid')),
                FpduiTableCell(child: Text('Credit Card')),
                FpduiTableCell(child: Text('\$250.00'), alignment: Alignment.centerRight),
              ],
            ),
            FpduiTableRow.row(
              context: context,
              children: const [
                FpduiTableCell(child: Text('INV002')),
                FpduiTableCell(child: Text('Pending')),
                FpduiTableCell(child: Text('PayPal')),
                FpduiTableCell(child: Text('\$150.00'), alignment: Alignment.centerRight),
              ],
            ),
             FpduiTableRow.row(
              context: context,
              children: const [
                FpduiTableCell(child: Text('INV003')),
                FpduiTableCell(child: Text('Unpaid')),
                FpduiTableCell(child: Text('Bank Transfer')),
                FpduiTableCell(child: Text('\$350.00'), alignment: Alignment.centerRight),
              ],
            ),
             FpduiTableRow.row(
              context: context,
              children: const [
                FpduiTableCell(child: Text('INV004')),
                FpduiTableCell(child: Text('Paid')),
                FpduiTableCell(child: Text('Credit Card')),
                FpduiTableCell(child: Text('\$450.00'), alignment: Alignment.centerRight),
              ],
            ),
            FpduiTableRow.row(
              context: context,
              children: const [
                FpduiTableCell(child: Text('Total')),
                FpduiTableCell(child: Text('')),
                FpduiTableCell(child: Text('')),
                FpduiTableCell(child: Text('\$1,200.00'), alignment: Alignment.centerRight),
              ],
            ),
          ],
        ),
        const FpduiTableCaption('A list of your recent invoices.'),
      ],
    );
  }
}
