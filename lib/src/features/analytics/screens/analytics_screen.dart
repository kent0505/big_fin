import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        SizedBox(
          height: 132,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 132,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        color: colors.tertiaryFour,
                        radius: 22,
                        value: 20,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        color: colors.accent,
                        radius: 22,
                        value: 20,
                        showTitle: false,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 24),
              SizedBox(
                width: 132,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        color: colors.tertiaryFour,
                        radius: 20,
                        value: 10,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        color: colors.system,
                        radius: 20,
                        value: 20,
                        showTitle: false,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 18),
        Text(
          'Categories',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 16,
            fontFamily: AppFonts.bold,
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 200,
          width: 200,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: colors.tertiaryOne,
                  radius: 10,
                  value: 20,
                  showTitle: false,
                ),
                PieChartSectionData(
                  color: colors.system,
                  radius: 10,
                  value: 20,
                  showTitle: false,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
