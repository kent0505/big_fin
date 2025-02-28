import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/widgets/svg_widget.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Color(0xff1B1B1B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: SvgWidget(
              Assets.cat1,
              width: 24,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Expense naaaaaaaam...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: AppFonts.bold,
                  ),
                ),
                Spacer(),
                Text(
                  'Category',
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
            '- \$85.50',
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 16,
              fontFamily: AppFonts.bold,
            ),
          ),
        ],
      ),
    );
  }
}
