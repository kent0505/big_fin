import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/models/expense.dart';
import '../bloc/expense_bloc.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  const ExpenseDetailsScreen({super.key, required this.expense});

  static const routePath = '/ExpenseDetailsScreen';

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      appBar: Appbar(
        title: expense.isIncome ? 'Income details' : 'Expense details',
        right: Button(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return DialogWidget(
                  title: 'Are you sure?',
                  description: 'You won’t be able to undo this action.',
                  leftTitle: 'Delete',
                  rightTitle: 'Cancel',
                  onYes: () {
                    context
                        .read<ExpenseBloc>()
                        .add(DeleteExpense(expense: expense));
                    context.pop();
                  },
                );
              },
            );
          },
          child: const SvgWidget(Assets.delete),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  expense.title,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 24,
                    fontFamily: AppFonts.bold,
                  ),
                ),
              ),
              Text(
                '${expense.isIncome ? '+' : '-'}\$${formatDouble(expense.amount)}',
                style: TextStyle(
                  color: expense.isIncome ? colors.accent : colors.system,
                  fontSize: 24,
                  fontFamily: AppFonts.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${expense.date} at ${expense.time}',
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 14,
              fontFamily: AppFonts.medium,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 48,
            child: Row(
              children: [
                Text(
                  'Category',
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 16,
                    fontFamily: AppFonts.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: colors.accent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      SvgWidget(
                        'assets/categories/cat${expense.assetID}.svg',
                        height: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        expense.catTitle,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: AppFonts.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            expense.note,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 14,
              fontFamily: AppFonts.medium,
            ),
          ),
          const SizedBox(height: 20),
          // attachments
        ],
      ),
    );
  }
}
