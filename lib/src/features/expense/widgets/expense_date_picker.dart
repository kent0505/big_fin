import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class ExpenseDatePicker extends StatelessWidget {
  const ExpenseDatePicker({
    super.key,
    required this.controller,
    required this.onPressed,
  });

  final TextEditingController controller;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Expanded(
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: colors.tertiaryOne,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Button(
          onPressed: onPressed,
          child: Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  controller.text,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 16,
                    fontFamily: AppFonts.dosis,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              SvgWidget(
                Assets.date1,
                color: colors.textPrimary,
              ),
              const SizedBox(width: 14),
            ],
          ),
        ),
      ),
    );
  }
}
