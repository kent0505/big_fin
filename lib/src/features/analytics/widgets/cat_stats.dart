import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/cat.dart';
import '../../../core/widgets/button.dart';
import '../screens/analytics_cat_screen.dart';

class CatStats extends StatelessWidget {
  const CatStats({
    super.key,
    required this.cat,
    required this.percent,
    required this.amount,
  });

  final Cat cat;
  final double percent;
  final double amount;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 2 - 20,
      height: 52,
      child: Button(
        onPressed: () {
          context.push(AnalyticsCatScreen.routePath, extra: cat);
        },
        child: Row(
          children: [
            Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cat.indicatorColor,
              ),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cat.title,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 14,
                    fontFamily: AppFonts.medium,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '$percent% - \$$amount',
                  style: TextStyle(
                    color: colors.textPrimary,
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
