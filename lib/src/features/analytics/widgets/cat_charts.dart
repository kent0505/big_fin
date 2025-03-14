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
              color: Color(0xffFF9500),
              radius: 170,
              lineWidth: 10,
            ),
            _Chart(
              percent: percents[2],
              color: Color(0xff007AFF),
              radius: 140,
              lineWidth: 10,
            ),
            _Chart(
              percent: percents[3],
              color: Color(0xff41FDA9),
              radius: 112,
              lineWidth: 10,
            ),
            _Chart(
              percent: percents[4],
              color: Color(0xffD4FF00),
              radius: 84,
              lineWidth: 10,
            ),
            _Chart(
              percent: percents[5],
              color: Color(0xffFF2D55),
              radius: 57,
              lineWidth: 6,
            ),
            _Chart(
              percent: percents[6],
              color: Color(0xffAF52DE),
              radius: 38,
              lineWidth: 4,
            ),
            _Chart(
              percent: percents[7],
              color: Color(0xff34C759),
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
      animationDuration: 500,
      radius: radius / 2,
      lineWidth: lineWidth,
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: color,
      backgroundColor: colors.tertiaryOne,
    );
  }
}
