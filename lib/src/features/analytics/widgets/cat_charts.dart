import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/config/my_colors.dart';

class CatCharts extends StatelessWidget {
  const CatCharts({
    super.key,
    required this.percents,
  }) : assert(percents.length == 8);

  final List<double> percents;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _Chart(
              percent: percents[0],
              color: colors.system,
              radius: 200,
              lineWidth: 10,
            ),
            _Chart(
              percent: percents[1],
              color: colors.orange,
              radius: 170,
              lineWidth: 10,
            ),
            _Chart(
              percent: percents[2],
              color: colors.orange,
              radius: 140,
              lineWidth: 10,
            ),
            _Chart(
              percent: percents[3],
              color: colors.accent,
              radius: 112,
              lineWidth: 10,
            ),
            _Chart(
              percent: percents[4],
              color: colors.yellow,
              radius: 84,
              lineWidth: 10,
            ),
            _Chart(
              percent: percents[5],
              color: colors.shopping,
              radius: 57,
              lineWidth: 6,
            ),
            _Chart(
              percent: percents[6],
              color: colors.violet,
              radius: 38,
              lineWidth: 4,
            ),
            _Chart(
              percent: percents[7],
              color: colors.green,
              radius: 24,
              lineWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({
    required this.percent,
    required this.color,
    required this.radius,
    required this.lineWidth,
  });

  final double percent;
  final Color color;
  final double radius;
  final double lineWidth;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return CircularPercentIndicator(
      percent: percent,
      animation: true,
      animationDuration: 1000,
      radius: radius / 2,
      lineWidth: lineWidth,
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: color,
      backgroundColor: colors.tertiaryOne,
    );
  }
}
