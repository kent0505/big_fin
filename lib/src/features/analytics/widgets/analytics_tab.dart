import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';

class AnalyticsTab extends StatelessWidget {
  const AnalyticsTab({
    super.key,
    required this.index,
    required this.onPressed,
  });

  final int index;
  final void Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 52,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ).copyWith(bottom: 8),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _Button(
            title: 'Week',
            index: 0,
            current: index,
            onPressed: onPressed,
          ),
          _Button(
            title: 'Month',
            index: 1,
            current: index,
            onPressed: onPressed,
          ),
          _Button(
            title: 'Year',
            index: 2,
            current: index,
            onPressed: onPressed,
          ),
          _Button(
            title: 'Custom',
            index: 3,
            current: index,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.title,
    required this.index,
    required this.current,
    required this.onPressed,
  });

  final String title;
  final int index;
  final int current;
  final void Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Expanded(
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: index == current ? colors.accent : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Button(
          onPressed: () {
            onPressed(index);
          },
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: index == current ? Colors.black : colors.textPrimary,
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
