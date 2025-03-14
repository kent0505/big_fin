import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/budget.dart';
import '../../../core/models/expense.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../expense/bloc/expense_bloc.dart';
import '../screens/edit_budget_screen.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard({super.key, required this.budget});

  final Budget budget;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 200,
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          if (state is ExpensesLoaded) {
            final current = monthToDate(budget.date);
            final sorted = state.expenses.where((expense) {
              DateTime date = stringToDate(expense.date);
              return budget.monthly
                  ? date.year == current.year && date.month == current.month
                  : date.year == current.year;
            }).toList();

            double exp = 0;

            for (Expense expense in sorted) {
              if (!expense.isIncome) {
                exp += double.tryParse(expense.amount) ?? 0;
              }
            }

            double amount = double.parse(budget.amount);
            double percent = amount > 0 ? (exp / amount).clamp(0, 1) : 0;

            return Button(
              onPressed: () {
                context.push(EditBudgetScreen.routePath, extra: budget);
              },
              child: Row(
                children: [
                  Expanded(
                    child: CircularPercentIndicator(
                      percent: percent,
                      animation: true,
                      animationDuration: 500,
                      radius: 132 / 2,
                      lineWidth: 20,
                      center: Text(
                        '${(percent * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          color: colors.accent,
                          fontSize: 24,
                          fontFamily: AppFonts.bold,
                        ),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: colors.accent,
                      backgroundColor: colors.tertiaryFour,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          budget.monthly
                              ? budget.date
                              : int.parse(budget.date.split(" ")[1]).toString(),
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 18,
                            fontFamily: AppFonts.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Total budget: \$${budget.amount}',
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 14,
                            fontFamily: AppFonts.medium,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Total expense',
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 14,
                            fontFamily: AppFonts.medium,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${exp.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 18,
                            fontFamily: AppFonts.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Available budget',
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 14,
                            fontFamily: AppFonts.medium,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${(amount - exp).toStringAsFixed(2)}',
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 18,
                            fontFamily: AppFonts.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
