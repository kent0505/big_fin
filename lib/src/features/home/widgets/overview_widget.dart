import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Row(
      children: [
        SizedBox(width: 16),
        Text(
          'Overview',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 16,
            fontFamily: AppFonts.bold,
          ),
        ),
        Spacer(),
        Button(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return _CalendarDialog();
              },
            );
          },
          child: SvgWidget(
            Assets.calendar,
            color: colors.textPrimary,
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}

class _CalendarDialog extends StatelessWidget {
  const _CalendarDialog();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Dialog(
      backgroundColor: colors.tertiaryOne,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 376,
        width: 358,
      ),
    );
  }
}
