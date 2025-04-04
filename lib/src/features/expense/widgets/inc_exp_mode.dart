import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';

class IncExpMode extends StatelessWidget {
  const IncExpMode({
    super.key,
    required this.isIncome,
    required this.onPressed,
  });

  final bool isIncome;
  final void Function(bool) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Container(
      height: 44,
      width: 180,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _Mode(
            title: l.income,
            value: true,
            current: isIncome,
            onPressed: onPressed,
          ),
          _Mode(
            title: l.expense,
            value: false,
            current: isIncome,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}

class _Mode extends StatelessWidget {
  const _Mode({
    required this.title,
    required this.value,
    required this.current,
    required this.onPressed,
  });

  final String title;
  final bool value;
  final bool current;
  final void Function(bool) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Expanded(
      child: Button(
        onPressed: value == current
            ? null
            : () {
                onPressed(value);
              },
        minSize: 36,
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            color: value == current ? colors.accent : null,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: value == current ? Colors.black : colors.textPrimary,
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
