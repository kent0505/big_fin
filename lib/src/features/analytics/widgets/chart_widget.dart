import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../core/config/my_colors.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({
    super.key,
    required this.color,
    required this.radius,
    required this.value1,
    required this.value2,
  });

  final Color color;
  final double radius;
  final double value1;
  final double value2;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return PieChart(
      duration: Duration(milliseconds: 100),
      PieChartData(
        sectionsSpace: 0,
        startDegreeOffset: -90,
        sections: [
          PieChartSectionData(
            color: color,
            radius: radius,
            value: value1,
            showTitle: false,
          ),
          PieChartSectionData(
            color: colors.tertiaryOne,
            radius: radius,
            value: value2,
            showTitle: false,
          ),
        ],
      ),
    );
  }
}
