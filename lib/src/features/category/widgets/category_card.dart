import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/router.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../models/cat.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Color(0xff1B1B1B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: cat.id == 0
            ? null
            : () {
                context.push(
                  AppRoutes.editCategory,
                  extra: cat,
                );
              },
        child: Row(
          children: [
            SizedBox(width: 16),
            SizedBox(
              width: 24,
              child: SvgWidget(
                cat.asset,
                width: 24,
                color: cat.colorID == 0 ? null : getColor(cat.colorID),
              ),
            ),
            SizedBox(width: 8),
            Text(
              cat.title,
              style: TextStyle(
                color: Colors.white,
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
