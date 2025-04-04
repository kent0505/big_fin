import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/cat.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/models/expense.dart';
import '../../category/bloc/category_bloc.dart';
import '../../settings/data/settings_repository.dart';
import '../bloc/expense_bloc.dart';
import '../widgets/attached_image.dart';
import 'attached_image_screen.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  const ExpenseDetailsScreen({super.key, required this.expense});

  static const routePath = '/ExpenseDetailsScreen';

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;
    final currency = context.read<SettingsRepository>().getCurrency();
    final categories = context.read<CategoryBloc>().categories;
    final category = categories.singleWhere(
      (element) => element.id == expense.catID,
      orElse: () => emptyCat,
    );

    return Scaffold(
      appBar: Appbar(
        title: expense.isIncome ? l.incomeDetails : l.expenseDetails,
        right: Button(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return DialogWidget(
                  title: l.areYouSure,
                  description: l.deleteDescription,
                  leftTitle: l.delete,
                  rightTitle: l.cancel,
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
                '${expense.isIncome ? '+' : '-'}$currency${formatDouble(expense.amount)}',
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
          if (category.title.isNotEmpty)
            SizedBox(
              height: 48,
              child: Row(
                children: [
                  Text(
                    l.category,
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
                          'assets/categories/cat${category.assetID}.svg',
                          height: 18,
                          color: category.getColor(),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          category.getTitle(context),
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
          if (expense.attachment1.isNotEmpty)
            Row(
              children: [
                AttachedImage(
                  path: expense.attachment1,
                  onPressed: expense.attachment1.isEmpty
                      ? null
                      : () {
                          context.push(
                            ImageViewScreen.routePath,
                            extra: expense.attachment1,
                          );
                        },
                ),
                SizedBox(width: 8),
                AttachedImage(
                  path: expense.attachment2,
                  onPressed: expense.attachment2.isEmpty
                      ? null
                      : () {
                          context.push(
                            ImageViewScreen.routePath,
                            extra: expense.attachment2,
                          );
                        },
                ),
                SizedBox(width: 8),
                AttachedImage(
                  path: expense.attachment3,
                  onPressed: expense.attachment3.isEmpty
                      ? null
                      : () {
                          context.push(
                            ImageViewScreen.routePath,
                            extra: expense.attachment3,
                          );
                        },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
