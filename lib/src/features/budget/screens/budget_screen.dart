import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/budget.dart';
import '../../../core/models/expense.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/no_data.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/tab_widget.dart';
import '../../expense/bloc/expense_bloc.dart';
import '../bloc/budget_bloc.dart';
import 'add_budget_screen.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  static const routePath = '/BudgetScreen';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: Appbar(
        title: l.budgets,
        right: Button(
          onPressed: () {
            context.push(AddBudgetScreen.routePath);
          },
          child: SvgWidget(
            Assets.add,
            color: colors.textPrimary,
          ),
        ),
      ),
      body: TabWidget(
        titles: [
          'Monthly',
          'Yearly',
        ],
        pages: [
          BlocBuilder<BudgetBloc, BudgetState>(
            builder: (context, state) {
              if (state is BudgetsLoaded) {
                final sorted =
                    state.budgets.where((element) => element.monthly).toList();

                if (sorted.isEmpty) {
                  return NoData(
                    title: 'Set Up Your First Monthly Budget',
                    description:
                        'It looks like you haven\'t set up any budgets yet. Press the "Set Up Budget" button to create your first monthly budget.',
                    onCreate: () {
                      context.push(AddBudgetScreen.routePath);
                    },
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: sorted.length,
                  itemBuilder: (context, index) {
                    return _BudgetCard(budget: sorted[index]);
                  },
                );
              }

              return const SizedBox();
            },
          ),
          BlocBuilder<BudgetBloc, BudgetState>(
            builder: (context, state) {
              if (state is BudgetsLoaded) {
                final sorted =
                    state.budgets.where((element) => !element.monthly).toList();

                if (sorted.isEmpty) {
                  return NoData(
                    title: 'Set Up Your First Yearly Budget',
                    description:
                        'It looks like you haven\'t set up any budgets yet. Press the "Set Up Budget" button to create your first yearly budget.',
                    onCreate: () {
                      context.push(AddBudgetScreen.routePath);
                    },
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: sorted.length,
                  itemBuilder: (context, index) {
                    return _BudgetCard(budget: sorted[index]);
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

class _BudgetCard extends StatelessWidget {
  const _BudgetCard({required this.budget});

  final Budget budget;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    double exp = 0;

    return Container(
      height: 200,
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: CircularPercentIndicator(
              percent: 0.5,
              animation: true,
              animationDuration: 100,
              radius: 132 / 2,
              lineWidth: 20,
              center: Text(
                '${56}%',
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
                BlocBuilder<ExpenseBloc, ExpenseState>(
                  builder: (context, state) {
                    if (state is ExpensesLoaded) {
                      final current = monthToDate(budget.date);
                      List<Expense> sortedList =
                          state.expenses.where((expense) {
                        DateTime date = stringToDate(expense.date);
                        return budget.monthly
                            ? date.year == current.year &&
                                date.month == current.month
                            : date.year == current.year;
                      }).toList();
                      for (Expense expense in sortedList) {
                        if (!expense.isIncome) {
                          exp += double.tryParse(expense.amount) ?? 0;
                        }
                      }

                      return Text(
                        '\$${exp.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 18,
                          fontFamily: AppFonts.bold,
                        ),
                      );
                    }

                    return const SizedBox();
                  },
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
                BlocBuilder<ExpenseBloc, ExpenseState>(
                  builder: (context, state) {
                    return Text(
                      '\$${(double.parse(budget.amount) - exp).toStringAsFixed(2)}',
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 18,
                        fontFamily: AppFonts.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
