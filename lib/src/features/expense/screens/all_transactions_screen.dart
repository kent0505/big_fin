import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/my_colors.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/txt_field.dart';
import '../../home/widgets/expense_card.dart';
import '../../../core/widgets/no_data.dart';
import '../bloc/expense_bloc.dart';
import 'add_expense_screen.dart';

class AllTransactionsScreen extends StatefulWidget {
  const AllTransactionsScreen({super.key});

  static const routePath = '/AllTransactionsScreen';

  @override
  State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Appbar(title: l.allTransactions),
      body: Column(
        children: [
          SizedBox(
            height: 68,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TxtField(
                controller: searchController,
                hintText: l.searchTransaction,
                search: true,
                onChanged: (_) {
                  setState(() {});
                },
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (context, state) {
                if (state is ExpensesLoaded) {
                  if (state.expenses.isEmpty) {
                    return NoData(
                      title: l.noTransactionTitle,
                      description: l.noTransactionDescription2,
                      onCreate: () {
                        context.push(AddExpenseScreen.routePath);
                      },
                    );
                  }

                  final sorted = state.expenses
                      .where(
                        (element) => element.title
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase()),
                      )
                      .toList();

                  if (sorted.isEmpty) {
                    return NoData(
                      title: l.noResult,
                      description: '',
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
    );
  }
}
