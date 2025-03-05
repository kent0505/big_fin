import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../widgets/chart_widget.dart';

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
                child: ChartWidget(
                  color: colors.accent,
                  radius: 20,
                  value1: 20,
                  value2: 10,
                ),
              ),
              SizedBox(width: 24),
              SizedBox(
                width: 132,
                child: ChartWidget(
                  color: colors.system,
                  radius: 20,
                  value1: 10,
                  value2: 10,
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
          child: ChartWidget(
            color: colors.system,
            radius: 10,
            value1: 10,
            value2: 5,
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
