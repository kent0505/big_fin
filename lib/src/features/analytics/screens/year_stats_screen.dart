import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class YearStatsScreen extends StatefulWidget {
  const YearStatsScreen({super.key});

  @override
  State<YearStatsScreen> createState() => _YearStatsScreenState();
}

class _YearStatsScreenState extends State<YearStatsScreen> {
  int _selectedYear = DateTime.now().year;

  void _changeYear(int offset) {
    setState(() {
      _selectedYear += offset;
    });
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
              onPressed: () => _changeYear(-1),
              child: SvgWidget(
                Assets.back,
                color: colors.textPrimary,
              ),
            ),
            Expanded(
              child: Text(
                '$_selectedYear',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 14,
                  fontFamily: AppFonts.medium,
                ),
              ),
            ),
            Button(
              onPressed: () => _changeYear(1),
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
