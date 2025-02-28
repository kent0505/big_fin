import 'package:flutter/material.dart';

import '../config/constants.dart';
import 'button.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.title,
    this.width,
    this.color,
    this.isActive = true,
    required this.onPressed,
  });

  final String title;
  final double? width;
  final Color? color;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 58,
      width: width,
      decoration: BoxDecoration(
        color: color ?? (isActive ? AppColors.main : Color(0xff485C53)),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Button(
        onPressed: isActive ? onPressed : null,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.black : Color(0xffB0B0B0),
              fontSize: 18,
              fontFamily: AppFonts.bold,
            ),
          ),
        ),
      ),
    );
  }
}
