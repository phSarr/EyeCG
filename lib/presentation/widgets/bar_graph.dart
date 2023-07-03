import 'package:eyecg/presentation/widgets/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraph extends StatelessWidget {
  final List weeklySummary;
  const BarGraph({Key? key, required this.weeklySummary}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    BarData myBarData = BarData(sunday: weeklySummary[0], monday: weeklySummary[1], tuesday: weeklySummary[2], wednesday: weeklySummary[3], thursday: weeklySummary[4], friday: weeklySummary[5], saturday: weeklySummary[6]);
    myBarData.initBarData();
    return BarChart(
      BarChartData(
        maxY: 200,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(show: true, topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getBottomTitles)),
        ),
        barGroups: myBarData.barData.map((data) => BarChartGroupData(x: data.x,barRods: [BarChartRodData(toY: data.y, width: 12,), ]),).toList(),
      )
    );
  }
}

Widget getBottomTitles(double val,TitleMeta meta){
  const style = TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold);
  Widget text = const Text("", style: style,);
  switch(val.toInt()){
    case 0:
      text = const Text("Sun", );
      break;
    case 1:
      text = const Text("Mon", );
      break;
    case 2:
      text = const Text("Tue", );
      break;
    case 3:
      text = const Text("Wed", );
      break;
    case 4:
      text = const Text("Thu", );
      break;
    case 5:
      text = const Text("Fri", );
      break;
    case 6:
      text = const Text("Sat", );
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}

