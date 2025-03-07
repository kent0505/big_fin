import 'package:flutter/material.dart';

import '../config/constants.dart';
import '../config/my_colors.dart';
import 'button.dart';
import 'svg_widget.dart';

class OptionsButton extends StatelessWidget {
  const OptionsButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return SizedBox(
      width: 100,
      child: Button(
        onPressed: onPressed,
        child: Row(
          children: [
            Spacer(),
            Text(
              title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 14,
                fontFamily: AppFonts.bold,
              ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              width: 24,
              child: SvgWidget(
                Assets.bottom,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
