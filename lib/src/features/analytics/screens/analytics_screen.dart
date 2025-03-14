import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/cat.dart';
import '../widgets/analytics_date_shift.dart';
import '../widgets/analytics_tab.dart';
import '../widgets/cat_charts.dart';
import '../widgets/cat_stats.dart';
import '../widgets/exp_inc_chart.dart';
import '../widgets/stats_card.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int _index = 0;
  DateTime _selectedDate = DateTime.now();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  void _onTab(int value) {
    setState(() {
      _index = value;
    });
  }

  void _shiftDate(int offset) {
    setState(() {
      switch (_index) {
        case 0:
          _startDate = _startDate.add(Duration(days: 7 * offset));
          _endDate = _startDate.add(Duration(days: 6));
        case 1:
          _selectedDate = DateTime(
            _selectedDate.year,
            _selectedDate.month + offset,
          );
        case 2:
          _selectedDate = DateTime(
            _selectedDate.year + offset,
            _selectedDate.month,
            _selectedDate.day,
          );
        case 3:
          _selectedDate = _selectedDate.add(Duration(days: offset));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _startDate = now.subtract(Duration(days: now.weekday - 1));
    _endDate = _startDate.add(Duration(days: 6));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Column(
      children: [
        AnalyticsTab(
          index: _index,
          onPressed: _onTab,
        ),
        AnalyticsDateShift(
          index: _index,
          startDate: _startDate,
          endDate: _endDate,
          selectedDate: _selectedDate,
          onShift1: () => _shiftDate(-1),
          onShift2: () => _shiftDate(1),
        ),
        SizedBox(height: 8),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              ExpIncChart(
                incomePercent: 0.6, // CHANGE
                expensePercent: 0.4, // CHANGE
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
              CatCharts(
                percents: [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5], // CHANGE
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  defaultCats.length,
                  (index) {
                    return CatStats(
                      cat: defaultCats[index],
                      percent: 12, // CHANGE
                      amount: 200, // CHANGE
                    );
                  },
                ),
              ),
              SizedBox(height: 18),
              Text(
                'Stats',
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 16,
                  fontFamily: AppFonts.bold,
                ),
              ),
              SizedBox(height: 8),
              StatsCard(
                transactions: 2, // CHANGE
                expensePerDay: 200, // CHANGE
                expensePerTransaction: 200, // CHANGE
                incomePerDay: 100, // CHANGE
                incomePerTransaction: 100, // CHANGE
              ),
            ],
          ),
        ),
      ],
    );
  }
}
