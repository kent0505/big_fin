import 'package:big_fin/src/core/utils.dart';
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
            const SizedBox(height: 16),
            BalanceCard(period: period),
            const SizedBox(height: 8),
            OverviewWidget(date: date),
            SortCategories(cat: cat),
            TodayWidget(date: date),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (context, state) {
                  if (state is ExpensesLoaded) {
                    final sorted = state.expenses.where((element) {
                      final parsedDate = stringToDate(element.date);
                      return parsedDate.year == date.year &&
                          parsedDate.month == date.month &&
                          parsedDate.day == date.day &&
                          (cat.title.isEmpty || element.catTitle == cat.title);
                    }).toList();

                    if (sorted.isEmpty) {
                      return const NoData(
                        title: 'There is nothing',
                        description:
                            'You have no transactions for this day. Click the plus button to create your first transaction.',
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: sorted.length,
                      itemBuilder: (context, index) {
                        return ExpenseCard(
                          expense: sorted[index],
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
        const AddButton(),
      ],
    );
  }
}
