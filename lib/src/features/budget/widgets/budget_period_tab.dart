import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';

class BudgetPeriodTab extends StatelessWidget {
  const BudgetPeriodTab({
    super.key,
    required this.monthly,
    required this.onPeriod,
  });

  final bool monthly;
  final void Function(bool) onPeriod;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Container(
      height: 52,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _Tab(
            title: l.monthly,
            active: monthly,
            onPeriod: () {
              onPeriod(true);
            },
          ),
          _Tab(
            title: l.yearly,
            active: !monthly,
            onPeriod: () {
              onPeriod(false);
            },
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.title,
    required this.active,
    required this.onPeriod,
  });

  final String title;
  final bool active;
  final VoidCallback onPeriod;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: active ? colors.accent : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Button(
          onPressed: onPeriod,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: active ? Colors.black : colors.textPrimary,
                fontSize: 14,
                fontFamily: AppFonts.medium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
