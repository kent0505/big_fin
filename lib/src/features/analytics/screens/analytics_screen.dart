import 'package:flutter/material.dart';

import '../../../core/widgets/tab_widget.dart';
import 'day_stats_screen.dart';
import 'month_stats_screen.dart';
import 'week_stats_screen.dart';
import 'year_stats_screen.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TabWidget(
      titles: ['Week', 'Month', 'Year', 'Custom'],
      pages: [
        WeekStatsScreen(),
        MonthStatsScreen(),
        YearStatsScreen(),
        DayStatsScreen(),
      ],
    );
  }
}
