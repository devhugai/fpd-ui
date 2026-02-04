import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import '../../components/data_table.dart';
import '../../components/button.dart';
import '../../components/badge.dart';
import '../../components/dropdown_menu.dart';

// Sample Data Model
class Payment {
  final String id;
  final double amount;
  final String status;
  final String email;

  Payment({required this.id, required this.amount, required this.status, required this.email});
}

class DataTablePage extends StatelessWidget {
  const DataTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample Data
    final data = [
      Payment(id: "m5gr84i9", amount: 316.00, status: "success", email: "ken99@yahoo.com"),
      Payment(id: "3u1reoj4", amount: 242.00, status: "success", email: "abe45@gmail.com"),
      Payment(id: "derv1ws0", amount: 837.00, status: "processing", email: "monserrat44@gmail.com"),
      Payment(id: "5kma53ae", amount: 874.00, status: "success", email: "silas22@gmail.com"),
      Payment(id: "bhqecj4p", amount: 721.00, status: "failed", email: "carmella@hotmail.com"),
       Payment(id: "m5gr84i9", amount: 316.00, status: "success", email: "ken99@yahoo.com"),
      Payment(id: "3u1reoj4", amount: 242.00, status: "success", email: "abe45@gmail.com"),
      Payment(id: "derv1ws0", amount: 837.00, status: "processing", email: "monserrat44@gmail.com"),
      Payment(id: "5kma53ae", amount: 874.00, status: "success", email: "silas22@gmail.com"),
      Payment(id: "bhqecj4p", amount: 721.00, status: "failed", email: "carmella@hotmail.com"),
    ];

    final columns = [
      FpduiDataColumn<Payment>(
        accessorKey: "Status",
        enableSorting: true,
        header: (_) => const Text("Status"),
        cell: (_, payment) => FpduiBadge(child: Text(payment.status), variant: FpduiBadgeVariant.outline),
      ),
      FpduiDataColumn<Payment>(
        accessorKey: "Email",
        enableSorting: true,
        flex: 2,
        header: (_) => const Text("Email"),
        cell: (_, payment) => Text(payment.email),
      ),
      FpduiDataColumn<Payment>(
        accessorKey: "Amount",
        enableSorting: true,
        header: (_) => const Align(alignment: Alignment.centerRight, child: Text("Amount")),
        cell: (_, payment) {
          final formatted = NumberFormat.simpleCurrency(locale: 'en_US').format(payment.amount);
          return Align(alignment: Alignment.centerRight, child: Text(formatted));
        },
      ),
      FpduiDataColumn<Payment>(
        header: (_) => const SizedBox(),
        cell: (context, payment) {
          return Align(
            alignment: Alignment.centerRight,
            child: FpduiDropdownMenu(
              trigger: FpduiButton(
                variant: FpduiButtonVariant.ghost,
                size: FpduiButtonSize.icon,
                child: const Icon(LucideIcons.moreHorizontal, size: 16),
              ),
              items: [
                FpduiDropdownMenuLabel(child: Text("Actions")),
                FpduiDropdownMenuItem(
                  child: Text("Copy payment ID"),
                  onTap: () {
                     // Clipboard implementation
                  },
                ),
                FpduiDropdownMenuSeparator(),
                FpduiDropdownMenuItem(child: Text("View customer")),
                FpduiDropdownMenuItem(child: Text("View payment details")),
              ],
            ),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Data Table')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Payments', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text('Manage your payments.', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            FpduiDataTable<Payment>(
              data: data,
              columns: columns,
              enableRowSelection: true,
            ),
          ],
        ),
      ),
    );
  }
}
