import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/my_colors.dart';
import '../../../core/models/expense.dart';
import '../../../core/utils.dart';
import '../../category/bloc/category_bloc.dart';
import '../../expense/bloc/expense_bloc.dart';
import '../bloc/analytics_bloc.dart';
import '../widgets/analytics_date_shift.dart';
import '../widgets/analytics_tab.dart';
import '../widgets/analytics_title.dart';
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
    _startDate = DateTime(_startDate.year, _startDate.month, _startDate.day);
    _endDate =
        DateTime(_endDate.year, _endDate.month, _endDate.day, 23, 59, 59);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        if (state is ExpensesLoaded) {
          // СОРТИРУЕТ РАСХОДЫ/ПРИХОДЫ ПО ВЫБРАННОЙ ДАТЕ

          final sorted = state.expenses.where(
            (element) {
              DateTime date = stringToDate(element.date);
              date = DateTime(date.year, date.month, date.day);

              switch (_index) {
                case 0:
                  return (date.isAfter(_startDate) ||
                          date.isAtSameMomentAs(_startDate)) &&
                      (date.isBefore(_endDate) ||
                          date.isAtSameMomentAs(_endDate));
                case 1:
                  return _selectedDate.year == date.year &&
                      _selectedDate.month == date.month;
                case 2:
                  return _selectedDate.year == date.year;
                case 3:
                  final state = context.watch<AnalyticsBloc>().state;
                  if (state is AnalyticsCustom) {
                    if (state.date1.year != 1 && state.date2.year != 1) {
                      return (date.isAfter(state.date1) ||
                              date.isAtSameMomentAs(state.date1)) &&
                          (date.isBefore(state.date2) ||
                              date.isAtSameMomentAs(state.date2));
                    }
                  }
                  return _selectedDate.year == date.year &&
                      _selectedDate.month == date.month &&
                      _selectedDate.day == date.day;
                default:
                  return false;
              }
            },
          ).toList();

          // СЧИТАЕТ ОБЩЕЕ КОЛИЧЕСТВО ПРИХОДОВ/РАСХОДОВ
          double inc = 0; // ПРИХОДЫ
          double exp = 0; // РАСХОДЫ
          for (Expense expense in sorted) {
            double amount = tryParseDouble(expense.amount);
            expense.isIncome ? inc += amount : exp += amount;
          }

          // ПРЕВРАЩАЕТ В ЧИСЛО ОТ 0 ДО 1
          double total = inc + exp;
          double incomePercent = total > 0 ? inc / total : 0;
          double expensePercent = total > 0 ? exp / total : 0;

          final categories = context.read<CategoryBloc>().categories;

          final baseColors = <Color>[
            colors.system,
            colors.orange,
            colors.blue,
            colors.yellow,
            colors.accent,
            colors.shopping,
            colors.violet,
          ];

          List<Color> indicatorColors = [];

          for (int i = 0; i < categories.length; i++) {
            if (i < baseColors.length) {
              indicatorColors.add(baseColors[i]);
            } else {
              indicatorColors.add(colors.green);
            }
          }

          List<double> categorySums = List.filled(categories.length, 0.0);
          double total2 = 0;

          // Считаем суммы по категориям
          for (final expense in sorted) {
            if (!expense.isIncome) {
              final index = categories.indexWhere(
                (cat) => cat.id == expense.catID,
              );
              if (index != -1) {
                final amount = tryParseDouble(expense.amount);
                categorySums[index] += amount;
                total2 += amount;
              }
            }
          }

          // Считаем проценты
          List<double> percents = total2 > 0
              ? categorySums.map((sum) => sum / total2).toList()
              : List.filled(categories.length, 0.0);

          // Обрезаем до 8 значений: первые 7 и сумма остальных
          List<double> limited8 = List.filled(8, 0.0);
          for (int i = 0; i < 7 && i < percents.length; i++) {
            limited8[i] = percents[i];
          }
          if (percents.length > 7) {
            limited8[7] = percents.sublist(7).fold(0.0, (a, b) => a + b);
          }

          // СЧИТАЕТ СРЕДНИЕ ЦИФРЫ
          Set<String> uniqueDays = sorted.map((e) => e.date).toSet();
          int totalDays = uniqueDays.isNotEmpty ? uniqueDays.length : 1;

          double expensePerDay = exp / totalDays;
          double incomePerDay = inc / totalDays;

          int incomeCount = sorted.where((e) => e.isIncome).length;
          int expenseCount = sorted.where((e) => !e.isIncome).length;

          double expensePerTransaction =
              expenseCount > 0 ? exp / expenseCount : 0;
          double incomePerTransaction = incomeCount > 0 ? inc / incomeCount : 0;

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
                  padding: const EdgeInsets.all(16),
                  children: [
                    ExpIncChart(
                      incomePercent: incomePercent,
                      expensePercent: expensePercent,
                    ),
                    const SizedBox(height: 18),
                    AnalyticsTitle(l.categories),
                    const SizedBox(height: 8),
                    CatCharts(percents: limited8),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(
                        categories.length,
                        (index) {
                          return CatStats(
                            cat: categories[index],
                            percent: percents[index] * 100,
                            amount: categorySums[index],
                            color: indicatorColors[index],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                    AnalyticsTitle(l.stats),
                    const SizedBox(height: 8),
                    StatsCard(
                      transactions: sorted.length,
                      expensePerDay: expensePerDay,
                      expensePerTransaction: expensePerTransaction,
                      incomePerDay: incomePerDay,
                      incomePerTransaction: incomePerTransaction,
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}
