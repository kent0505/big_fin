import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/svg_widget.dart';

class StarsWidget extends StatelessWidget {
  const StarsWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final themeBrightness = Theme.of(context).brightness;
    final systemBrightness = MediaQuery.of(context).platformBrightness;
    final isDark = themeBrightness == Brightness.dark ||
        (themeBrightness == Brightness.dark &&
            systemBrightness == Brightness.dark);

    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 16,
            fontFamily: AppFonts.bold,
          ),
        ),
        const SizedBox(height: 2),
        const SvgWidget(Assets.stars),
        SvgWidget(
          height: 50,
          isDark ? Assets.leaves1 : Assets.leaves2,
        ),
      ],
    );
  }
}
