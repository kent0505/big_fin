import 'package:big_fin/src/features/language/bloc/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/models/expense.dart';
import '../../expense/bloc/expense_bloc.dart';
import '../bloc/home_bloc.dart';

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Row(
      children: [
        SizedBox(width: 16),
        Expanded(
          child: Text(
            l.overview,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 16,
              fontFamily: AppFonts.bold,
            ),
          ),
        ),
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

class _DatePickDialog extends StatefulWidget {
  const _DatePickDialog({required this.date});

  final DateTime date;

  @override
  State<_DatePickDialog> createState() => _DatePickDialogState();
}

class _DatePickDialogState extends State<_DatePickDialog> {
  DateTime _current = DateTime.now();

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
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;
    final locale = context.watch<LanguageBloc>().state.languageCode;

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
                    getMonthYear(_current, locale: locale),
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 18,
                      fontFamily: AppFonts.bold,
                    ),
                  ),
                ),
                Button(
                  onPressed: () => _changeMonth(-1),
                  child: SvgWidget(
                    Assets.back,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(width: 8),
                Button(
                  onPressed: () => _changeMonth(1),
                  child: SvgWidget(
                    Assets.right,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _Weekday(l.monday),
                _Weekday(l.tuesday),
                _Weekday(l.wednesday),
                _Weekday(l.thursday),
                _Weekday(l.friday),
                _Weekday(l.saturday),
                _Weekday(l.sunday),
              ],
            ),
            Column(
              children: List.generate(6, (weekIndex) {
                return Row(
                  children: _getWeek(_current, weekIndex).map((date) {
                    return _Day(
                      date: date,
                      current: _current,
                      selected: date == widget.date,
                      onPressed: () {
                        context.read<HomeBloc>().add(SortByDate(date: date));
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
    final now = DateTime.now();

    return SizedBox(
      height: 54,
      width: 44,
      child: Column(
        children: [
          Button(
            onPressed: onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: selected ? colors.accent : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 2,
                  color: date.day == now.day &&
                          date.month == now.month &&
                          date.year == now.year
                      ? colors.accent
                      : Colors.transparent,
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
          ),
          BlocBuilder<ExpenseBloc, ExpenseState>(
            builder: (context, state) {
              if (state is ExpensesLoaded) {
                bool hasExpense = false;
                bool hasIncome = false;

                for (Expense expense in state.expenses) {
                  DateTime parsed = stringToDate(expense.date);
                  if (parsed.year == date.year &&
                      parsed.month == date.month &&
                      parsed.day == date.day) {
                    expense.isIncome ? hasExpense = true : hasIncome = true;
                  }
                }

                if (hasExpense || hasIncome) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (hasExpense) _Indicator(true),
                      if (hasExpense && hasIncome) SizedBox(width: 4),
                      if (hasIncome) _Indicator(false),
                    ],
                  );
                }
              }

              return SizedBox();
            },
          ),
        ],
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
