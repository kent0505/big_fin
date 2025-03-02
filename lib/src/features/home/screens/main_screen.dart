import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/enums.dart';
import '../../category/models/cat.dart';
import '../../expense/bloc/expense_bloc.dart';
import '../widgets/add_button.dart';
import '../widgets/balance_card.dart';
import '../widgets/expense_card.dart';
import '../widgets/overview_widget.dart';
import '../widgets/sort_categories.dart';
import '../widgets/today_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
    required this.period,
    required this.cat,
  });

  final Period period;
  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 16),
            BalanceCard(),
            const SizedBox(height: 8),
            OverviewWidget(),
            SortCategories(cat: cat),
            TodayWidget(),
            SizedBox(height: 8),
            BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (context, state) {
                return state is ExpensesLoaded
                    ? Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          itemCount: state.expenses.length,
                          itemBuilder: (context, index) {
                            return ExpenseCard(
                              expense: state.expenses[index],
                            );
                          },
                        ),
                      )
                    : SizedBox();
              },
            ),
          ],
        ),
        AddButton(),
      ],
    );
  }
}
