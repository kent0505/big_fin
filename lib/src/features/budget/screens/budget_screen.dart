import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  static const routePath = '/BudgetScreen';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      appBar: Appbar(
        title: 'Budgets',
        right: Button(
          onPressed: () {
            // context.push(AppRoutes.addCategory);
          },
          child: SvgWidget(
            Assets.add,
            color: colors.textPrimary,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [],
      ),
    );
  }
}
