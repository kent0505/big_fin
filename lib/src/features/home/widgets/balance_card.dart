import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/widgets/svg_widget.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 88,
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              width: 1,
              color: Color(0xffE5FFF4),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Monthly balance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      '+ \$150.80',
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: AppColors.main,
                        fontSize: 24,
                        fontFamily: AppFonts.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    'January',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      '\$350.80 left',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: AppFonts.medium,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            _IncomeExpenseCard(false),
            SizedBox(width: 8),
            _IncomeExpenseCard(true),
          ],
        ),
      ],
    );
  }
}

class _IncomeExpenseCard extends StatelessWidget {
  const _IncomeExpenseCard(this.expense);

  final bool expense;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 56,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 1,
            color: Color(0xffE5FFF4),
          ),
        ),
        child: Column(
          children: [
            Text(
              expense ? 'Expense' : 'Income',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: AppFonts.medium,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 24,
                  child: SvgWidget(
                    expense ? Assets.expense : Assets.income,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  '\$100.00',
                  style: TextStyle(
                    color: expense ? AppColors.accent : AppColors.main,
                    fontSize: 14,
                    fontFamily: AppFonts.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
