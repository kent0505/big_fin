import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/router.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';

class TodayWidget extends StatelessWidget {
  const TodayWidget({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today =
        date.day == now.day && date.month == now.month && date.year == now.year;

    return Row(
      children: [
        SizedBox(width: 16),
        Text(
          '${today ? 'Today, ' : ''}${dateToString(date)}',
          style: TextStyle(
            color: Color(0xffB0B0B0),
            fontSize: 12,
            fontFamily: AppFonts.medium,
          ),
        ),
        Spacer(),
        SizedBox(
          width: 66,
          child: Button(
            onPressed: () {
              context.push(AppRoutes.allTransactions);
            },
            child: Text(
              'See all',
              style: TextStyle(
                color: AppColors.main,
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
