import 'package:fl_chart/fl_chart.dart';
/// Responsible for displaying documentation for Chart component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: chart.dart, component_page.
import 'package:flutter/material.dart';
import '../../components/chart.dart';
import '../../components/card.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Charts')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Charts', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
             const SizedBox(height: 8),
            const Text('Beautiful charts. Built using fl_chart.', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            
            // Line Chart
            const FpduiCard(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Line Chart - Sales", style: TextStyle(fontWeight: FontWeight.w600)),
                    SizedBox(height: 16),
                    FpduiLineChart(
                      height: 250,
                      data: [
                        FlSpot(0, 3),
                        FlSpot(1, 1),
                        FlSpot(2, 4),
                        FlSpot(3, 3),
                        FlSpot(4, 2),
                        FlSpot(5, 5),
                        FlSpot(6, 4),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Bar Chart
             FpduiCard(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Bar Chart - Revenue", style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    FpduiBarChart(
                      height: 250,
                      data: const [4, 6, 3, 7, 5, 8, 2],
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
