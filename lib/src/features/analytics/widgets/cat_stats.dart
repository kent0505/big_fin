import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/cat.dart';
import '../../../core/widgets/button.dart';
import '../../settings/data/settings_repository.dart';
import '../screens/analytics_cat_screen.dart';

class CatStats extends StatelessWidget {
  const CatStats({
    super.key,
    required this.cat,
    required this.percent,
    required this.amount,
    required this.color,
  });

  final Cat cat;
  final double percent;
  final double amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final currency = context.read<SettingsRepository>().getCurrency();

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
                color: color,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cat.getTitle(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 14,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${percent.toStringAsFixed(2)}% - $currency${amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 14,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
