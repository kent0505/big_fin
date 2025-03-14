import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class AnalyticsDateShift extends StatelessWidget {
  const AnalyticsDateShift({
    super.key,
    required this.index,
    required this.startDate,
    required this.endDate,
    required this.selectedDate,
    required this.onShift1,
    required this.onShift2,
  });

  final int index;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime selectedDate;
  final VoidCallback onShift1;
  final VoidCallback onShift2;

  String _formatDate(int index) {
    switch (index) {
      case 0:
        return '${DateFormat('d MMM').format(startDate)} - ${DateFormat('d MMM').format(endDate)}';
      case 1:
        return DateFormat('MMMM yyyy').format(selectedDate);
      case 2:
        return DateFormat('yyyy').format(selectedDate);
      case 3:
        return DateFormat('d MMM, yyyy').format(selectedDate);
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Row(
      children: [
        SizedBox(width: 16),
        Button(
          onPressed: onShift1,
          child: SvgWidget(
            Assets.back,
            color: colors.textPrimary,
          ),
        ),
        Expanded(
          child: Text(
            _formatDate(index),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 14,
              fontFamily: AppFonts.medium,
            ),
          ),
        ),
        Button(
          onPressed: onShift2,
          child: SvgWidget(
            Assets.right,
            color: colors.textPrimary,
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}
