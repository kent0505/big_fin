import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/no_data.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/tab_widget.dart';
import '../bloc/budget_bloc.dart';
import '../widgets/budget_card.dart';
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
          l.monthly,
          l.yearly,
        ],
        pages: [
          BlocBuilder<BudgetBloc, BudgetState>(
            builder: (context, state) {
              if (state is BudgetsLoaded) {
                final sorted =
                    state.budgets.where((element) => element.monthly).toList();

                if (sorted.isEmpty) {
                  return NoData(
                    title: l.firstMonthlyBudgetTitle,
                    description: l.firstMonthlyBudgetDescription,
                    onCreate: () {
                      context.push(AddBudgetScreen.routePath);
                    },
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: sorted.length,
                  itemBuilder: (context, index) {
                    return BudgetCard(budget: sorted[index]);
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
                    title: l.firstYearlyBudgetTitle,
                    description: l.firstYearlyBudgetDescription,
                    onCreate: () {
                      context.push(AddBudgetScreen.routePath);
                    },
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: sorted.length,
                  itemBuilder: (context, index) {
                    return BudgetCard(budget: sorted[index]);
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
