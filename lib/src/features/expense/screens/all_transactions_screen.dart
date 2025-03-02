import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/txt_field.dart';
import '../../home/widgets/expense_card.dart';
import '../../home/widgets/no_data.dart';
import '../bloc/expense_bloc.dart';

class AllTransactionsScreen extends StatefulWidget {
  const AllTransactionsScreen({super.key});

  @override
  State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Appbar(title: 'All transactions'),
      body: Column(
        children: [
          SizedBox(
            height: 68,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TxtField(
                controller: searchController,
                hintText: 'Search transaction',
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
                      title: 'There is nothing',
                      description:
                          'You haven’t made any transactions yet. Tap the button below to create your first one.',
                      create: true,
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
                      title: 'No result',
                      description: ' ',
                    );
                  }

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
    );
  }
}
