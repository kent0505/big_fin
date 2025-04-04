import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class ExpenseAttachment extends StatelessWidget {
  const ExpenseAttachment({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: onPressed,
        child: Row(
          children: [
            SizedBox(width: 16),
            SvgWidget(
              Assets.diamond,
              height: 24,
            ),
            SizedBox(width: 8),
            SvgWidget(
              Assets.attachment,
              color: colors.textPrimary,
            ),
            SizedBox(width: 8),
            Text(
              l.addAttachment,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 14,
                fontFamily: AppFonts.bold,
              ),
            ),
            Spacer(),
            SvgWidget(Assets.right),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
