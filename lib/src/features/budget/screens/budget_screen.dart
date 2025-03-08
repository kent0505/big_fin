import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/no_data.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/tab_widget.dart';
import 'add_budget_screen.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  static const routePath = '/BudgetScreen';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: Appbar(
        title: l.budgets,
        right: Button(
          onPressed: () {
            context.push(AddBudgetScreen.routePath);
          },
          child: SvgWidget(
            Assets.add,
            color: colors.textPrimary,
          ),
        ),
      ),
      body: TabWidget(
        titles: [
          'Monthly',
          'Yearly',
        ],
        pages: [
          NoData(
            title: 'Set Up Your First Monthly Budget',
            description:
                'It looks like you haven\'t set up any budgets yet. Press the "Set Up Budget" button to create your first monthly budget.',
            onCreate: () {
              context.push(AddBudgetScreen.routePath);
            },
          ),
          NoData(
            title: 'Set Up Your First Yearly Budget',
            description:
                'It looks like you haven\'t set up any budgets yet. Press the "Set Up Budget" button to create your first yearly budget.',
            onCreate: () {
              context.push(AddBudgetScreen.routePath);
            },
          ),
        ],
      ),
    );
  }
}
