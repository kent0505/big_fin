import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../expense/screens/add_expense_screen.dart';

class NoData extends StatelessWidget {
  const NoData({
    super.key,
    required this.title,
    required this.description,
    this.create = false,
  });

  final String title;
  final String description;
  final bool create;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 16,
              fontFamily: AppFonts.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 14,
              fontFamily: AppFonts.medium,
              height: 1.6,
            ),
          ),
          SizedBox(height: 16),
          if (create)
            Container(
              height: 58,
              width: 180,
              decoration: BoxDecoration(
                color: colors.accent,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Button(
                onPressed: () {
                  context.push(AddExpenseScreen.routePath);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgWidget(
                      Assets.add,
                      color: Colors.black,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Create',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: AppFonts.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
