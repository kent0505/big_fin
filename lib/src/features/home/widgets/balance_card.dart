import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/enums.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/budget.dart';
import '../../../core/models/expense.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../budget/bloc/budget_bloc.dart';
import '../../expense/bloc/expense_bloc.dart';
import '../../language/bloc/language_bloc.dart';
import '../../settings/data/settings_repository.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;
    final currency = context.read<SettingsRepository>().getCurrency();
    final state = context.watch<ExpenseBloc>().state;

    Period period = Period.monthly;
    List<Expense> sortedList = [];
    double x = 0;
    double y = 0;
    double z = 0;
    double monthExpenses = 0;

    if (state is ExpensesLoaded) {
      period = state.period;
      DateTime now = DateTime.now();
      DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      DateTime endOfWeek = startOfWeek.add(const Duration(
        days: 6,
        hours: 23,
        minutes: 59,
        seconds: 59,
      ));

      if (state.period == Period.monthly) {
        sortedList = state.expenses.where((expense) {
          DateTime date = stringToDate(expense.date);
          return date.year == now.year && date.month == now.month;
        }).toList();
      } else if (state.period == Period.weekly) {
        sortedList = state.expenses.where((expense) {
          DateTime date = stringToDate(expense.date);
          return (date.isAfter(startOfWeek) ||
                  date.isAtSameMomentAs(startOfWeek)) &&
              (date.isBefore(endOfWeek) || date.isAtSameMomentAs(endOfWeek));
        }).toList();
      } else {
        sortedList = state.expenses.where((expense) {
          DateTime date = stringToDate(expense.date);
          return date.year == now.year &&
              date.month == now.month &&
              date.day == now.day;
        }).toList();
      }
      for (Expense expense in sortedList) {
        expense.isIncome
            ? x += tryParseDouble(expense.amount)
            : y += tryParseDouble(expense.amount);
      }
      z = x - y;
      final sortedMonth = state.expenses.where((expense) {
        DateTime date = stringToDate(expense.date);
        return date.year == now.year && date.month == now.month;
      }).toList();
      for (Expense expense in sortedMonth) {
        if (!expense.isIncome) {
          monthExpenses += tryParseDouble(expense.amount);
        }
      }
    }

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
                        ? l.monthlyBalance
                        : period == Period.weekly
                            ? l.weeklyBalance
                            : l.dailyBalance,
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 14,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      '$currency${z.toStringAsFixed(2).replaceAll('-', '')}',
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: z > 0 ? colors.accent : colors.system,
                        fontSize: 24,
                        fontFamily: AppFonts.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  BlocBuilder<LanguageBloc, Locale>(
                    builder: (context, state) {
                      return Text(
                        DateFormat(
                          'MMMM',
                          state.languageCode,
                        ).format(DateTime.now()),
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 12,
                          fontFamily: AppFonts.medium,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: BlocBuilder<BudgetBloc, BudgetState>(
                      builder: (context, state) {
                        if (state is BudgetsLoaded) {
                          double amount = 0;

                          for (Budget budget in state.budgets) {
                            final current = monthToDate(budget.date);
                            final now = DateTime.now();
                            if (budget.monthly &&
                                now.month == current.month &&
                                now.year == current.year) {
                              amount += tryParseDouble(budget.amount);
                            }
                          }

                          return Text(
                            '$currency${(amount - monthExpenses).toStringAsFixed(2)} ${l.left}',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontSize: 12,
                              fontFamily: AppFonts.medium,
                            ),
                          );
                        }

                        return const SizedBox();
                      },
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
              currency: currency,
              amount: x,
            ),
            const SizedBox(width: 8),
            _IncomeExpenseCard(
              isIncome: false,
              currency: currency,
              amount: y,
            ),
            const SizedBox(width: 16),
          ],
        ),
      ],
    );
  }
}

class _IncomeExpenseCard extends StatelessWidget {
  const _IncomeExpenseCard({
    required this.isIncome,
    required this.currency,
    required this.amount,
  });

  final bool isIncome;
  final String currency;
  final double amount;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

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
              isIncome ? l.income : l.expense,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 12,
                fontFamily: AppFonts.medium,
              ),
            ),
            const Spacer(),
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
                const SizedBox(width: 4),
                Text(
                  '$currency${amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: isIncome ? colors.accent : colors.system,
                    fontSize: 14,
                    fontFamily: AppFonts.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
