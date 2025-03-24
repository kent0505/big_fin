import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/calc_result.dart';
import '../../../core/widgets/button.dart';

class CalculationCard extends StatelessWidget {
  const CalculationCard({
    super.key,
    required this.calc,
    this.selected1 = false,
    this.selected2 = false,
    this.onPressed,
  });

  final CalcResult calc;
  final bool selected1;
  final bool selected2;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: 92,
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
        border: selected1 || selected2
            ? Border.all(
                width: 2,
                color: selected1 ? colors.accent : colors.violet,
              )
            : null,
      ),
      child: Button(
        onPressed: onPressed,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.totalEnergyCosumption,
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 14,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${l.costOfConsumedElectricity} (${calc.currency})',
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 14,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  calc.energy,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 16,
                    fontFamily: AppFonts.bold,
                  ),
                ),
                Spacer(),
                Text(
                  calc.cost,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 16,
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
