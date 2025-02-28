import 'package:flutter/material.dart';

import '../config/constants.dart';
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 58,
      decoration: BoxDecoration(
        color: active ? AppColors.main : Color(0xff485C53),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Button(
        onPressed: active ? onPressed : null,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: active ? Colors.black : Color(0xffB0B0B0),
              fontSize: 18,
              fontFamily: AppFonts.bold,
            ),
          ),
        ),
      ),
    );
  }
}
