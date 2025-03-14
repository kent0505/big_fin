import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';

class ExpIncChart extends StatelessWidget {
  const ExpIncChart({
    super.key,
    required this.incomePercent,
    required this.expensePercent,
  }) : assert(incomePercent <= 1 &&
            expensePercent <= 1 &&
            incomePercent >= 0 &&
            expensePercent >= 0);

  final double incomePercent;
  final double expensePercent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Chart(
          percent: incomePercent,
          isIncome: true,
        ),
        SizedBox(width: 24),
        _Chart(
          percent: expensePercent,
          isIncome: false,
        ),
      ],
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({
    required this.percent,
    required this.isIncome,
  });

  final double percent;
  final bool isIncome;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return CircularPercentIndicator(
      percent: percent,
      animation: true,
      animationDuration: 500,
      radius: 132 / 2,
      lineWidth: 20,
      center: Text(
        '${(percent * 100).toStringAsFixed(0)}%',
        style: TextStyle(
          color: isIncome ? colors.accent : colors.system,
          fontSize: 24,
          fontFamily: AppFonts.bold,
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: isIncome ? colors.accent : colors.system,
      backgroundColor: colors.tertiaryFour,
    );
  }
}
