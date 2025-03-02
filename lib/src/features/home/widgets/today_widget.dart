import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/router.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';

class TodayWidget extends StatelessWidget {
  const TodayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16),
        Text(
          'Today, ${dateToString(DateTime.now())}',
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
              context.push(AppRoutes.all);
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
