import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/cat.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/models/expense.dart';
import '../../category/bloc/category_bloc.dart';
import '../../expense/screens/expense_details_screen.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final categories = context.read<CategoryBloc>().categories;
    final category = categories.singleWhere(
      (element) => element.id == expense.catID,
      orElse: () => emptyCat,
    );

    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: () {
          context.push(ExpenseDetailsScreen.routePath, extra: expense);
        },
        child: Row(
          children: [
            if (category.title.isNotEmpty) ...[
              SizedBox(
                width: 24,
                child: SvgWidget(
                  'assets/categories/cat${category.assetID}.svg',
                  width: 24,
                  color: category.getColor(),
                ),
              ),
              const SizedBox(width: 8),
            ],
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
                        color: colors.textPrimary,
                        fontSize: 16,
                        fontFamily: AppFonts.bold,
                      ),
                    ),
                  ),
                  Text(
                    category.getTitle(context),
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 14,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${expense.isIncome ? '+' : '-'} \$${formatDouble(expense.amount)}',
              style: TextStyle(
                color: expense.isIncome ? colors.accent : colors.system,
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
