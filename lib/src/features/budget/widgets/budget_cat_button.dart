import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/cat.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class BudgetCatButton extends StatelessWidget {
  const BudgetCatButton({
    super.key,
    required this.cat,
    required this.active,
    required this.onPressed,
  });

  final Cat cat;
  final bool active;
  final void Function(Cat) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 52,
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: () {
          onPressed(cat);
        },
        child: Row(
          children: [
            const SizedBox(width: 16),
            SvgWidget(
              'assets/categories/cat${cat.assetID}.svg',
              width: 24,
              color: cat.colorID == 0 ? null : cat.getColor(),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                cat.getTitle(context),
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 14,
                  fontFamily: AppFonts.medium,
                ),
              ),
            ),
            SizedBox(width: 4),
            if (active) SvgWidget(Assets.check),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
