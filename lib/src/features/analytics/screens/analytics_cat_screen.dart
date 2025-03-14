import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/cat.dart';
import '../../../core/widgets/appbar.dart';
import '../../expense/bloc/expense_bloc.dart';
import '../../home/widgets/expense_card.dart';
import '../widgets/analytics_date_shift.dart';
import '../widgets/analytics_tab.dart';
import '../widgets/exp_inc_chart.dart';
import '../widgets/stats_card.dart';

class AnalyticsCatScreen extends StatefulWidget {
  const AnalyticsCatScreen({super.key, required this.cat});

  final Cat cat;

  static const routePath = '/AnalyticsCatScreen';

  @override
  State<AnalyticsCatScreen> createState() => _AnalyticsCatScreenState();
}

class _AnalyticsCatScreenState extends State<AnalyticsCatScreen> {
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

    return Scaffold(
      appBar: Appbar(title: widget.cat.title),
      body: Column(
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
                  'Transactions',
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 16,
                    fontFamily: AppFonts.bold,
                  ),
                ),
                SizedBox(height: 8),
                BlocBuilder<ExpenseBloc, ExpenseState>(
                  builder: (context, state) {
                    if (state is ExpensesLoaded) {
                      final sorted = state.expenses
                          .where(
                            (element) => element.catTitle == widget.cat.title,
                          )
                          .toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: sorted.length,
                        itemBuilder: (context, index) {
                          return ExpenseCard(expense: sorted[index]);
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
                SizedBox(height: 10),
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
      ),
    );
  }
}
