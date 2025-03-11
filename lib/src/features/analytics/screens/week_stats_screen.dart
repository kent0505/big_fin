import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class WeekStatsScreen extends StatefulWidget {
  const WeekStatsScreen({super.key});

  @override
  State<WeekStatsScreen> createState() => _WeekStatsScreenState();
}

class _WeekStatsScreenState extends State<WeekStatsScreen> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  String _formatDateRange() {
    return '${DateFormat('d MMM').format(_startDate)} - ${DateFormat('d MMM').format(_endDate)}';
  }

  void _changeWeek(int offset) {
    setState(() {
      _startDate = _startDate.add(Duration(days: 7 * offset));
      _endDate = _startDate.add(Duration(days: 6));
    });
  }

  @override
  void initState() {
    super.initState();
    _startDate = _getStartOfWeek(DateTime.now());
    _endDate = _startDate.add(Duration(days: 6));
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
              onPressed: () => _changeWeek(-1),
              child: SvgWidget(
                Assets.back,
                color: colors.textPrimary,
              ),
            ),
            Expanded(
              child: Text(
                _formatDateRange(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 14,
                  fontFamily: AppFonts.medium,
                ),
              ),
            ),
            Button(
              onPressed: () => _changeWeek(1),
              child: SvgWidget(
                Assets.right,
                color: colors.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
