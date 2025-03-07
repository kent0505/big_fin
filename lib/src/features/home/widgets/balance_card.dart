import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/enums.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../expense/bloc/expense_bloc.dart';
import '../../expense/models/expense.dart';
import '../models/balance.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key, required this.period});

  final Period period;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Column(
      children: [
        Container(
          height: 88,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              width: 1,
              color: colors.textPrimary,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    period == Period.monthly
                        ? 'Monthly balance'
                        : period == Period.weekly
                            ? 'Weekly balance'
                            : 'Daily balance',
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 14,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: BlocBuilder<ExpenseBloc, ExpenseState>(
                      builder: (context, state) {
                        if (state is ExpensesLoaded) {
                          final balance = period == Period.monthly
                              ? _getMonthlyBalance(state.expenses)
                              : period == Period.weekly
                                  ? _getWeeklyBalance(state.expenses)
                                  : _getDailyBalance(state.expenses);

                          final formatted = balance.incomes - balance.expenses;

                          return Text(
                            '\$${formatted.toStringAsFixed(2).replaceAll('-', '')}',
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color:
                                  formatted > 0 ? colors.accent : colors.system,
                              fontSize: 24,
                              fontFamily: AppFonts.bold,
                            ),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    'January',
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 12,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      '\$350.80 left',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 12,
                        fontFamily: AppFonts.medium,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const SizedBox(width: 16),
            _IncomeExpenseCard(
              isIncome: true,
              period: period,
            ),
            const SizedBox(width: 8),
            _IncomeExpenseCard(
              isIncome: false,
              period: period,
            ),
            const SizedBox(width: 16),
          ],
        ),
      ],
    );
  }
}

class _IncomeExpenseCard extends StatelessWidget {
  const _IncomeExpenseCard({required this.isIncome, required this.period});

  final bool isIncome;
  final Period period;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Expanded(
      child: Container(
        height: 56,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 1,
            color: colors.textPrimary,
          ),
        ),
        child: Column(
          children: [
            Text(
              isIncome ? 'Income' : 'Expense',
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 12,
                fontFamily: AppFonts.medium,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 24,
                  child: SvgWidget(
                    isIncome ? Assets.income : Assets.expense,
                    color: isIncome ? colors.accent : colors.system,
                  ),
                ),
                SizedBox(width: 4),
                BlocBuilder<ExpenseBloc, ExpenseState>(
                  builder: (context, state) {
                    if (state is ExpensesLoaded) {
                      final balance = period == Period.monthly
                          ? _getMonthlyBalance(state.expenses)
                          : period == Period.weekly
                              ? _getWeeklyBalance(state.expenses)
                              : _getDailyBalance(state.expenses);

                      final formatted =
                          isIncome ? balance.incomes : balance.expenses;

                      return Text(
                        '\$${formatted.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: isIncome ? colors.accent : colors.system,
                          fontSize: 14,
                          fontFamily: AppFonts.bold,
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// String _formatBalance(double amount) {
//   return amount.toStringAsFixed(2) ;
// }

Balance _getMonthlyBalance(List<Expense> expenses) {
  DateTime now = DateTime.now();
  int currentYear = now.year;
  int currentMonth = now.month;
  List<Expense> sortedList = expenses.where((expense) {
    DateTime date = stringToDate(expense.date);
    return date.year == currentYear && date.month == currentMonth;
  }).toList();
  double x = 0;
  double y = 0;
  for (Expense expense in sortedList) {
    expense.isIncome
        ? x += double.tryParse(expense.amount) ?? 0
        : y += double.tryParse(expense.amount) ?? 0;
  }
  return Balance(
    incomes: x,
    expenses: y,
  );
}

Balance _getWeeklyBalance(List<Expense> expenses) {
  DateTime now = DateTime.now();
  DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  List<Expense> sortedList = expenses.where((expense) {
    DateTime date = stringToDate(expense.date);
    return date.isAfter(startOfWeek) || date.isAtSameMomentAs(startOfWeek);
  }).toList();
  double x = 0;
  double y = 0;
  for (Expense expense in sortedList) {
    expense.isIncome
        ? x += double.tryParse(expense.amount) ?? 0
        : y += double.tryParse(expense.amount) ?? 0;
  }
  return Balance(incomes: x, expenses: y);
}

Balance _getDailyBalance(List<Expense> expenses) {
  DateTime now = DateTime.now();
  List<Expense> sortedList = expenses.where((expense) {
    DateTime date = stringToDate(expense.date);
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }).toList();
  double x = 0;
  double y = 0;
  for (Expense expense in sortedList) {
    expense.isIncome
        ? x += double.tryParse(expense.amount) ?? 0
        : y += double.tryParse(expense.amount) ?? 0;
  }
  return Balance(incomes: x, expenses: y);
}
