import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/router.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      bottom: 10,
      child: Button(
        onPressed: () {
          context.push(AppRoutes.addExpense);
        },
        child: Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            color: Color(0xff41FDA9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: SvgWidget(
              Assets.add,
              height: 40,
              color: AppColors.bg,
            ),
          ),
        ),
      ),
    );
  }
}
