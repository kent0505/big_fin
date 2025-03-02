import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/router.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../expense/models/expense.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Color(0xff1B1B1B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: () {
          context.push(AppRoutes.expense, extra: expense);
        },
        child: Row(
          children: [
            SizedBox(
              width: 24,
              child: SvgWidget(
                'assets/categories/cat${expense.assetID}.svg',
                width: 24,
                color: getColor(expense.colorID),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      expense.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: AppFonts.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    expense.catTitle,
                    style: TextStyle(
                      color: Color(0xffB0B0B0),
                      fontSize: 14,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Text(
              '${expense.isIncome ? '+' : '-'} \$${expense.amount}',
              style: TextStyle(
                color: expense.isIncome ? AppColors.main : AppColors.accent,
                fontSize: 16,
                fontFamily: AppFonts.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
