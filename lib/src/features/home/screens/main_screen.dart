import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/enums.dart';
import '../../category/models/cat.dart';
import '../../expense/bloc/expense_bloc.dart';
import '../widgets/add_button.dart';
import '../widgets/balance_card.dart';
import '../widgets/expense_card.dart';
import '../widgets/no_data.dart';
import '../widgets/overview_widget.dart';
import '../widgets/sort_categories.dart';
import '../widgets/today_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
    required this.period,
    required this.date,
    required this.cat,
  });

  final Period period;
  final DateTime date;
  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 16),
            BalanceCard(period: period),
            const SizedBox(height: 8),
            OverviewWidget(date: date),
            SortCategories(cat: cat),
            TodayWidget(date: date),
            SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (context, state) {
                  if (state is ExpensesLoaded) {
                    if (state.expenses.isEmpty) {
                      return NoData(
                        title: 'There is nothing',
                        description:
                            'You have no transactions for this day. Click the plus button to create your first transaction.',
                      );
                    }

                    final sorted = cat.title.isNotEmpty
                        ? state.expenses
                            .where((element) => element.catTitle == cat.title)
                            .toList()
                        : state.expenses;

                    return ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: sorted.length,
                      itemBuilder: (context, index) {
                        return ExpenseCard(
                          expense: sorted[index],
                        );
                      },
                    );
                  }

                  return SizedBox();
                },
              ),
            ),
          ],
        ),
        AddButton(),
      ],
    );
  }
}
