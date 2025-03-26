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

    return Button(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 14,
              fontFamily: AppFonts.bold,
            ),
          ),
          const SizedBox(width: 4),
          SvgWidget(
            Assets.bottom,
            width: 24,
            color: colors.textPrimary,
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
