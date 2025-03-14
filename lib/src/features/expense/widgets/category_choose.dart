import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/models/cat.dart';

class CategoryChoose extends StatelessWidget {
  const CategoryChoose({
    super.key,
    required this.cat,
    required this.current,
    required this.onPressed,
  });

  final Cat cat;
  final Cat current;
  final void Function(Cat) onPressed;

  @override
  Widget build(BuildContext context) {
    final active =
        cat.assetID == current.assetID && cat.colorID == current.colorID;
    final colors = Theme.of(context).extension<MyColors>()!;

    return Button(
      onPressed: active
          ? null
          : () {
              onPressed(cat);
            },
      minSize: 32,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: active ? colors.accent : null,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 1,
            color: active ? colors.accent : colors.tertiaryFour,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgWidget(
              'assets/categories/cat${cat.assetID}.svg',
              height: 18,
              color: getColor(cat.colorID),
            ),
            const SizedBox(width: 4),
            Text(
              cat.title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 14,
                fontFamily: AppFonts.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
