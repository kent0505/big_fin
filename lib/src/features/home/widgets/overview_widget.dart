import 'package:flutter/material.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({super.key, required this.date});

  final DateTime date;

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
                return _DatePickDialog(date: date);
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

// class _CalendarDialog extends StatelessWidget {
//   const _CalendarDialog();

//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).extension<MyColors>()!;

//     return Dialog(
//       backgroundColor: colors.tertiaryOne,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: SizedBox(
//         height: 376,
//         width: 358,
//       ),
//     );
//   }
// }

class _DatePickDialog extends StatefulWidget {
  const _DatePickDialog({required this.date});

  final DateTime date;

  @override
  State<_DatePickDialog> createState() => _DatePickDialogState();
}

class _DatePickDialogState extends State<_DatePickDialog> {
  DateTime _current = DateTime.now();
  DateTime _selectedDate = DateTime.now();

  void _changeMonth(int offset) {
    setState(() {
      _current = DateTime(_current.year, _current.month + offset, 1);
    });
  }

  List<DateTime> _generateMonthDays(DateTime current) {
    final firstDay = DateTime(current.year, current.month, 1);
    int startWeekday = (firstDay.weekday + 6) % 7;
    DateTime firstVisibleDate = firstDay.subtract(Duration(days: startWeekday));
    return List.generate(42, (i) => firstVisibleDate.add(Duration(days: i)));
  }

  List<DateTime> _getWeek(DateTime date, int index) {
    return _generateMonthDays(date).skip(index * 7).take(7).toList();
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    getMonthYear(_current),
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 18,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                ),
                Button(
                  onPressed: () => _changeMonth(-1),
                  child: const SvgWidget('assets/back.svg'),
                ),
                SizedBox(width: 8),
                Button(
                  onPressed: () => _changeMonth(1),
                  child: const RotatedBox(
                    quarterTurns: 2,
                    child: SvgWidget('assets/back.svg'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                _Weekday('Mon'),
                _Weekday('Tue'),
                _Weekday('Wed'),
                _Weekday('Thu'),
                _Weekday('Fri'),
                _Weekday('Sat'),
                _Weekday('Sun'),
              ],
            ),
            Column(
              children: List.generate(6, (weekIndex) {
                return Row(
                  children: _getWeek(_current, weekIndex).map((date) {
                    return _Day(
                      date: date,
                      current: _current,
                      selected: date == _selectedDate,
                      onPressed: () {
                        setState(() {
                          _selectedDate = date;
                        });
                        Navigator.pop(context, date);
                      },
                    );
                  }).toList(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _Day extends StatelessWidget {
  const _Day({
    required this.date,
    required this.current,
    required this.selected,
    required this.onPressed,
  });

  final DateTime date;
  final DateTime current;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Button(
      onPressed: onPressed,
      child: SizedBox(
        height: 54,
        width: 44,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: selected ? colors.accent : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 2,
                  color: isToday(date) ? colors.accent : Colors.transparent,
                ),
              ),
              child: Center(
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                    color: date.month == current.month
                        ? selected
                            ? Colors.black
                            : colors.textPrimary
                        : colors.tertiaryFour,
                    fontSize: 16,
                    fontFamily: AppFonts.bold,
                  ),
                ),
              ),
            ),
            // if (hasSameDate([], date))
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Indicator(true),
                SizedBox(width: 4),
                _Indicator(false),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Weekday extends StatelessWidget {
  const _Weekday(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return SizedBox(
      width: 44,
      height: 32,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: colors.textSecondary,
            fontSize: 14,
            fontFamily: AppFonts.medium,
          ),
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator(this.isIncome);

  final bool isIncome;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isIncome ? colors.accent : colors.system,
      ),
    );
  }
}
