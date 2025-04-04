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
            const SizedBox(width: 16),
            const SvgWidget(
              Assets.diamond,
              height: 24,
            ),
            const SizedBox(width: 8),
            SvgWidget(
              Assets.attachment,
              color: colors.textPrimary,
            ),
            const SizedBox(width: 8),
            Text(
              l.addAttachment,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 14,
                fontFamily: AppFonts.bold,
              ),
            ),
            const Spacer(),
            const SvgWidget(Assets.right),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
