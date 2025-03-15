import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils.dart';
import '../../../core/models/cat.dart';
import '../../../core/widgets/no_data.dart';
import '../../expense/bloc/expense_bloc.dart';
import '../widgets/overview_widget.dart';
import '../widgets/add_button.dart';
import '../widgets/balance_card.dart';
import '../widgets/expense_card.dart';
import '../widgets/sort_categories.dart';
import '../widgets/today_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
    required this.date,
    required this.cat,
  });

  final DateTime date;
  final Cat cat;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 16),
            BalanceCard(),
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
                      return NoData(
                        title: l.noTransactionTitle,
                        description: l.noTransactionDescription1,
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: sorted.length,
                      itemBuilder: (context, index) {
                        return ExpenseCard(expense: sorted[index]);
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
