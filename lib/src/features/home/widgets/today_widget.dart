import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../expense/screens/all_transactions_screen.dart';

class TodayWidget extends StatelessWidget {
  const TodayWidget({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today =
        date.day == now.day && date.month == now.month && date.year == now.year;
    final colors = Theme.of(context).extension<MyColors>()!;

    return Row(
      children: [
        SizedBox(width: 16),
        Text(
          '${today ? 'Today, ' : ''}${dateToString(date)}',
          style: TextStyle(
            color: colors.textSecondary,
            fontSize: 12,
            fontFamily: AppFonts.medium,
          ),
        ),
        Spacer(),
        SizedBox(
          width: 66,
          child: Button(
            onPressed: () {
              context.push(AllTransactionsScreen.routePath);
            },
            child: Text(
              'See all',
              style: TextStyle(
                color: colors.accent,
                fontSize: 14,
                fontFamily: AppFonts.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}
