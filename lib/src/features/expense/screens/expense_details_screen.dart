import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/svg_widget.dart';
import '../bloc/expense_bloc.dart';
import '../models/expense.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  const ExpenseDetailsScreen({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
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
          child: SvgWidget(Assets.delete),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  expense.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: AppFonts.bold,
                  ),
                ),
              ),
              Text(
                '${expense.isIncome ? '+' : '-'}\$${formatDouble(expense.amount)}',
                style: TextStyle(
                  color: expense.isIncome ? AppColors.main : AppColors.accent,
                  fontSize: 24,
                  fontFamily: AppFonts.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            '${expense.date} at ${expense.time}',
            style: TextStyle(
              color: Color(0xffB0B0B0),
              fontSize: 14,
              fontFamily: AppFonts.medium,
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 48,
            child: Row(
              children: [
                Text(
                  'Category',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: AppFonts.bold,
                  ),
                ),
                Spacer(),
                Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.main,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      SvgWidget(
                        'assets/categories/cat${expense.assetID}.svg',
                        height: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        expense.catTitle,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: AppFonts.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Text(
            expense.note,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: AppFonts.medium,
            ),
          ),
          SizedBox(height: 20),
          // attachments
        ],
      ),
    );
  }
}
