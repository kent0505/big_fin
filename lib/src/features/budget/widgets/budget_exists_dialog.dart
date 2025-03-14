import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';

class BudgetExistsDialog extends StatelessWidget {
  const BudgetExistsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Dialog(
      child: SizedBox(
        width: 270,
        height: 120,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text(
              'Date already exists!',
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontFamily: AppFonts.bold,
              ),
            ),
            Spacer(),
            Container(
              height: 0.5,
              color: Color(0xff545458).withValues(alpha: 0.65),
            ),
            Button(
              onPressed: () {
                context.pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'OK',
                    style: TextStyle(
                      color: colors.blue,
                      fontSize: 16,
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
