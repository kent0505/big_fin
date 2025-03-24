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
      duration: const Duration(milliseconds: 500),
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
              color: active ? colors.bg : colors.textSecondary,
              fontSize: 18,
              fontFamily: AppFonts.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonWrapper extends StatelessWidget {
  const ButtonWrapper({
    super.key,
    required this.button,
    this.transparent = false,
  });

  final MainButton button;
  final bool transparent;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 78 + MediaQuery.of(context).viewPadding.bottom,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ).copyWith(top: 10),
      alignment: Alignment.topCenter,
      color: transparent ? null : colors.bg,
      child: button,
    );
  }
}
