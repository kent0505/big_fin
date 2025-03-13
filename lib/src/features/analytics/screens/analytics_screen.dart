import 'package:big_fin/src/core/config/my_colors.dart';
import 'package:big_fin/src/core/models/expense.dart';
import 'package:big_fin/src/features/expense/bloc/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../core/widgets/tab_widget.dart';
import 'select_time_periodic.dart';

/// {@template analytics_screen}
/// AnalyticsScreen widget.
/// {@endtemplate}
class AnalyticsScreen extends StatefulWidget {
  /// {@macro analytics_screen}
  const AnalyticsScreen({
    super.key, // ignore: unused_element
  });

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

/// State for widget AnalyticsScreen.
class _AnalyticsScreenState extends State<AnalyticsScreen> {
  late final ValueNotifier<int> _timePeriodNotifer;

  late final IncomeExpenseController _incomeExpenseController;

  /* #region Lifecycle */
  @override
  void initState() {
    _timePeriodNotifer = ValueNotifier(0);
    _incomeExpenseController = IncomeExpenseController();
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(covariant AnalyticsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The configuration of InheritedWidgets has changed
    // Also called after initState but before build
  }

  @override
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) {
    final expenceState = context.watch<ExpenseBloc>().state;
    final width = MediaQuery.sizeOf(context).width;

    final color = Theme.of(context).extension<MyColors>()!;
    return BlocListener<ExpenseBloc, ExpenseState>(
      listener: (context, state) {
        if (state is ExpensesLoaded) {
          _incomeExpenseController.calculateIncomeAndExpense(state.expenses);

          _incomeExpenseController.calculateIncomeExpensePercentage();
        }
      },
      child: ValueListenableBuilder(
          valueListenable: _timePeriodNotifer,
          builder: (context, timePeriodIndex, child) {
            return Column(
              children: [
                TabWidget(
                  titles: ['Week', 'Month', 'Year', 'Custom'],
                  onTap: (index) {
                    _timePeriodNotifer.value = index;
                  },
                ),
                Expanded(
                  child: SelectTimePeriodicWidget(
                      timePeriodIndex: timePeriodIndex),
                ),
                ListenableBuilder(
                    listenable: _incomeExpenseController,
                    builder: (context, child) {
                      return Expanded(
                        flex: 1,
                        child: switch (expenceState) {
                          ExpensesLoaded expensesLoaded =>
                            Builder(builder: (context) {
                              final income = _incomeExpenseController
                                          .incomeExpensePercentage.$2;
                              return SafeArea(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircularPercentIndicator(
                                      percent: 0.5,
                                      animation: true,
                                      animationDuration: 100,
                                      radius: width / 5,
                                      lineWidth: 20,
                                      center: Text('$income'),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: color.accent,
                                      backgroundColor: color.tertiaryOne,
                                      progressBorderColor: color.accent,
                                    ),
                                    CircularPercentIndicator(radius: width / 5),
                                  ],
                                ),
                              );
                            }),
                          _ => Text('$expenceState'),
                        },
                      );
                    }),
              ],
            );
          }),
    );
  }

  double calculateIncomeAndExpense(int income, int expense) {
    int result = income - expense;

    return result / income;
  }
}

/// {@template analytics_screen}
/// IncomeExpenseController.
/// {@endtemplate}
final class IncomeExpenseController extends ChangeNotifier {
  /// {@macro analytics_screen}

  double _incomes = 0.0;

  double _expenses = 0.0;

  /// $1 incomePercentage  $2 expensePercentage.
  (double, double) _incomeExpensePercentage = (0.0, 0.0);

  (double, double) get incomeExpensePercentage => _incomeExpensePercentage;

  void calculateIncomeAndExpense(List<Expense> expenseList) {
    final incomes = <double>[];

    final expenses = <double>[];

    for (var e in expenseList) {
      final amount = double.parse(e.amount);
      if (e.isIncome) {
        incomes.add(amount);
      } else {
        expenses.add(amount);
      }
    }

    double totalIncome = incomes.fold(0.0, (sum, income) => sum + income);

    // Суммируем все расходы
    double totalExpense = expenses.fold(0.0, (sum, expense) => sum + expense);

    _incomes = totalIncome;

    _expenses = totalExpense;

    notifyListeners();
  }

  void calculateIncomeExpensePercentage() {
    if (_incomes == 0) {
      _incomeExpensePercentage = (0.0, 0.0);
    }

    double incomePercentage =
        (_incomes != 0) ? (_incomes / (_incomes + _expenses)) * 100 : 0.0;
    double expensePercentage =
        (_expenses != 0) ? (_expenses / (_incomes + _expenses)) * 100 : 0.0;

    _incomeExpensePercentage = (incomePercentage, expensePercentage);
    notifyListeners();
  }
}
