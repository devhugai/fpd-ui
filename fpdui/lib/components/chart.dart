// Responsible for visualizing data graphically.
// Provides FpduiChart (and likely wraps fl_chart or similar).
//
// Used by: Analytics dashboards.
// Depends on: fl_chart, fpdui_theme.
// Assumes: Data provided in compatible format.
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

// A standardized container for charts with tooltip styling and colors
class FpduiChartInfo {
  static LineTouchData lineTouchData(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    
    return LineTouchData(
      handleBuiltInTouches: true,
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (touchedSpot) => fpduiTheme.popover,
        tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        tooltipBorder: BorderSide(color: fpduiTheme.border),
        getTooltipItems: (touchedSpots) {
          return touchedSpots.map((LineBarSpot touchedSpot) {
            return LineTooltipItem(
              touchedSpot.y.toString(),
              TextStyle(
                color: fpduiTheme.popoverForeground,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            );
          }).toList();
        },
      ),
    );
  }

  static BarTouchData barTouchData(BuildContext context) {
     final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    
    return BarTouchData(
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (group) => fpduiTheme.popover,
        tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        tooltipBorder: BorderSide(color: fpduiTheme.border),
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          return BarTooltipItem(
            rod.toY.round().toString(),
            TextStyle(
              color: fpduiTheme.popoverForeground,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          );
        },
      ),
    );
  }
  
  static FlGridData gridData(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      getDrawingHorizontalLine: (value) => FlLine(
        color: fpduiTheme.border.withValues(alpha: 0.5),
        strokeWidth: 1,
        dashArray: [5, 5], // Dashed grid
      ),
    );
  }
  
  static FlTitlesData titlesData(BuildContext context, {bool showBottom = true, bool showLeft = false}) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    
    return FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: showBottom,
          reservedSize: 30,
          getTitlesWidget: (value, meta) {
             // Default simplistic title mapping (index based)
             return Padding(
               padding: const EdgeInsets.only(top: 8.0),
               child: Text(
                 value.toInt().toString(),
                 style: TextStyle(
                   color: fpduiTheme.mutedForeground,
                   fontSize: 12,
                 ),
               ),
             );
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: showLeft,
          reservedSize: 40,
           getTitlesWidget: (value, meta) {
             return Text(
                 value.toInt().toString(),
                 style: TextStyle(
                   color: fpduiTheme.mutedForeground,
                   fontSize: 12,
                 ),
               );
           }
        ),
      ),
    );
  }
  
  static FlBorderData borderData(BuildContext context) {
    return FlBorderData(show: false);
  }
}

class FpduiLineChart extends StatelessWidget {
  const FpduiLineChart({
    super.key,
    required this.data,
    this.height = 200,
    this.color,
  });

  final List<FlSpot> data; // Simple list of points for MVP
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    final chartColor = color ?? fpduiTheme.primary;

    return SizedBox(
      height: height,
      child: LineChart(
        LineChartData(
          gridData: FpduiChartInfo.gridData(context),
          titlesData: FpduiChartInfo.titlesData(context, showLeft: false), // Clean look means usually no left axis or minimal
          borderData: FpduiChartInfo.borderData(context),
          lineTouchData: FpduiChartInfo.lineTouchData(context),
          lineBarsData: [
            LineChartBarData(
              spots: data,
              isCurved: true,
              color: chartColor,
              barWidth: 2, // stroke-2
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: chartColor.withValues(alpha: 0.1), // fill-primary/10
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FpduiBarChart extends StatelessWidget {
  const FpduiBarChart({
    super.key,
    required this.data, // List of Y values for simplicity
    this.height = 200,
    this.color,
  });

  final List<double> data;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    final chartColor = color ?? fpduiTheme.primary;

    return SizedBox(
      height: height,
      child: BarChart(
        BarChartData(
           gridData: FpduiChartInfo.gridData(context),
           titlesData: FpduiChartInfo.titlesData(context, showLeft: false),
           borderData: FpduiChartInfo.borderData(context),
           barTouchData: FpduiChartInfo.barTouchData(context),
           barGroups: data.asMap().entries.map((entry) {
             return BarChartGroupData(
               x: entry.key,
               barRods: [
                 BarChartRodData(
                   toY: entry.value,
                   color: chartColor,
                   width: 20, // w-5 approx
                   borderRadius: const BorderRadius.vertical(top: Radius.circular(4)), // rounded-t-sm
                   backDrawRodData: BackgroundBarChartRodData(show: false),
                 ),
               ],
             );
           }).toList(),
        ),
      ),
    );
  }
}
