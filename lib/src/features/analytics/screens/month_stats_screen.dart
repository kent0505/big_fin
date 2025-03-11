import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class MonthStatsScreen extends StatefulWidget {
  const MonthStatsScreen({super.key});

  @override
  State<MonthStatsScreen> createState() => _MonthStatsScreenState();
}

class _MonthStatsScreenState extends State<MonthStatsScreen> {
  DateTime _selectedMonth = DateTime.now();

  void _changeMonth(int offset) {
    setState(() {
      _selectedMonth = DateTime(
        _selectedMonth.year,
        _selectedMonth.month + offset,
      );
    });
  }

  String _formatMonth() {
    return DateFormat('MMMM yyyy').format(_selectedMonth);
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
              onPressed: () => _changeMonth(-1),
              child: SvgWidget(
                Assets.back,
                color: colors.textPrimary,
              ),
            ),
            Expanded(
              child: Text(
                _formatMonth(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 14,
                  fontFamily: AppFonts.medium,
                ),
              ),
            ),
            Button(
              onPressed: () => _changeMonth(1),
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
