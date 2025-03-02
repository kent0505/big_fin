import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16),
        Text(
          'Overview',
          style: TextStyle(
            color: Colors.white,
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
          child: SvgWidget(Assets.calendar),
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
    return Dialog(
      backgroundColor: AppColors.card,
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
