import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';

class TitleText extends StatelessWidget {
  const TitleText(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Text(
      title,
      style: TextStyle(
        color: colors.textPrimary,
        fontSize: 14,
        fontFamily: AppFonts.bold,
      ),
    );
  }
}
