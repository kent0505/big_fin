import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/title_text.dart';
import '../screens/compare_screen.dart';

class ComparisonTab extends StatelessWidget {
  const ComparisonTab({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Container(
          height: 222,
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colors.bg,
                colors.linear2,
              ],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _BarChart(value1: 80),
                    SizedBox(width: 8),
                    _BarChart(value1: 60, second: true),
                    SizedBox(width: 16),
                    _BarChart(value1: 60),
                    SizedBox(width: 8),
                    _BarChart(value1: 60, second: true),
                    SizedBox(width: 16),
                    _BarChart(value1: 60),
                    SizedBox(width: 8),
                    _BarChart(value1: 60, second: true),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  _ChartTitle('Energy Consumption'),
                  _ChartTitle('Operating Cost'),
                  _ChartTitle('Efficiency'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.accent,
                    ),
                  ),
                  SizedBox(width: 3),
                  Text(
                    'First result',
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 10,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffAF52DE),
                    ),
                  ),
                  SizedBox(width: 3),
                  Text(
                    'Second result',
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 10,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 28),
        Row(
          children: [
            Expanded(
              child: TitleText('Recent calculations'),
            ),
            Button(
              onPressed: () {
                context.push(CompareScreen.routePath);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Compare other',
                  style: TextStyle(
                    color: colors.accent,
                    fontSize: 14,
                    fontFamily: AppFonts.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BarChart extends StatelessWidget {
  const _BarChart({
    required this.value1,
    this.second = false,
  });

  final double value1;
  final bool second;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: value1,
      width: 45,
      decoration: BoxDecoration(
        color: second ? Color(0xffAF52DE) : colors.accent,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
          bottom: Radius.circular(8),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 8),
          Text(
            value1.toString(),
            style: TextStyle(
              color: colors.tertiaryOne,
              fontSize: 8,
              fontFamily: AppFonts.medium,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartTitle extends StatelessWidget {
  const _ChartTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Expanded(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colors.textPrimary,
          fontSize: 8,
          fontFamily: AppFonts.medium,
        ),
      ),
    );
  }
}
