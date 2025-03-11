import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class DayStatsScreen extends StatefulWidget {
  const DayStatsScreen({super.key});

  @override
  State<DayStatsScreen> createState() => _DayStatsScreenState();
}

class _DayStatsScreenState extends State<DayStatsScreen> {
  DateTime _selectedDate = DateTime.now();

  void _changeDay(int offset) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: offset));
    });
  }

  String _formatDay() {
    return DateFormat('d MMM, yyyy').format(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Button(
              onPressed: () => _changeDay(-1),
              child: SvgWidget(
                Assets.back,
                color: colors.textPrimary,
              ),
            ),
            Expanded(
              child: Text(
                _formatDay(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 14,
                  fontFamily: AppFonts.medium,
                ),
              ),
            ),
            Button(
              onPressed: () => _changeDay(1),
              child: SvgWidget(
                Assets.right,
                color: colors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
