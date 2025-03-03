import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../expense/screens/add_expense_screen.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Positioned(
      right: 16,
      bottom: 10,
      child: Button(
        onPressed: () {
          context.push(AddExpenseScreen.routePath);
        },
        child: Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            color: colors.accent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: SvgWidget(
              Assets.add,
              height: 40,
              color: colors.bg,
            ),
          ),
        ),
      ),
    );
  }
}
