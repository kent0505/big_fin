import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../models/cat.dart';
import '../screens/category_screen.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 52,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: cat.id < 9
            ? null
            : () {
                context.push(
                  CategoryScreen.routePath,
                  extra: cat,
                );
              },
        child: Row(
          children: [
            const SizedBox(width: 16),
            SizedBox(
              width: 24,
              child: SvgWidget(
                'assets/categories/cat${cat.assetID}.svg',
                width: 24,
                color: cat.colorID == 0 ? null : getColor(cat.colorID),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              cat.title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 14,
                fontFamily: AppFonts.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
