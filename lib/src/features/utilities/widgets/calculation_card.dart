import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';

class CalculationCard extends StatelessWidget {
  const CalculationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 92,
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: () {},
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Energy Cosumption (kWh)',
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 14,
                      fontFamily: AppFonts.medium,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Cost of Consumed Electricity (USD)',
                    // maxLines: 1,
                    // overflow: TextOverflow.ellipsis,
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
              children: [
                Text(
                  '1000',
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 16,
                    fontFamily: AppFonts.bold,
                  ),
                ),
                Spacer(),
                Text(
                  '1000',
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
