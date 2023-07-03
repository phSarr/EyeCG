import 'package:eyecg/presentation/widgets/bar_graph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartBp extends StatelessWidget {
  final List weeklySummaryH;
  final List weeklySummaryL;
  const BarChartBp({Key? key, required this.weeklySummaryH,required this.weeklySummaryL}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    late List<BarChartGroupData> rawBarGroups;
    late List<BarChartGroupData> showingBarGroups;
    final barGroup1 = makeGroupData(0, weeklySummaryH[0], weeklySummaryL[0]);
    final barGroup2 = makeGroupData(1, weeklySummaryH[1], weeklySummaryL[1]);
    final barGroup3 = makeGroupData(2, weeklySummaryH[2], weeklySummaryL[2]);
    final barGroup4 = makeGroupData(3, weeklySummaryH[3], weeklySummaryL[3]);
    final barGroup5 = makeGroupData(4, weeklySummaryH[4], weeklySummaryL[4]);
    final barGroup6 = makeGroupData(5, weeklySummaryH[5], weeklySummaryL[5]);
    final barGroup7 = makeGroupData(6, weeklySummaryH[6], weeklySummaryL[6]);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
    return  BarChart(
      BarChartData(
        maxY: 200,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(show: true, topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getBottomTitles)),
        ),
        barGroups: showingBarGroups,
      ),
    );
  }
}

BarChartGroupData makeGroupData(int x, double y1, double y2) {
  return BarChartGroupData(
    barsSpace: 4,
    x: x,
    barRods: [
      BarChartRodData(
        toY: y1,
        color: Color(0xFF2196F3),
        width: 7,
      ),
      BarChartRodData(
        toY: y2,
        color: Color(0xFF50E4FF),
        width: 7,
      ),
    ],
  );
}
