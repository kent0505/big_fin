import 'package:flutter/material.dart';

import '../config/constants.dart';
import '../config/my_colors.dart';
import 'button.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.title,
    this.active = true,
    required this.onPressed,
  });

  final String title;
  final bool active;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 58,
      decoration: BoxDecoration(
        color: active ? colors.accent : colors.tertiaryThree,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Button(
        onPressed: active ? onPressed : null,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: active ? colors.textPrimary : colors.textSecondary,
              fontSize: 18,
              fontFamily: AppFonts.bold,
            ),
          ),
        ),
      ),
    );
  }
}
