import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../features/analytics/bloc/analytics_bloc.dart';
import '../../features/expense/bloc/expense_bloc.dart';
import '../../features/language/bloc/language_bloc.dart';
import '../config/constants.dart';
import '../config/my_colors.dart';
import '../models/expense.dart';
import '../utils.dart';
import 'button.dart';
import 'svg_widget.dart';

class DatePick extends StatefulWidget {
  const DatePick({
    super.key,
    required this.date,
    this.range = false,
  });

  final DateTime date;
  final bool range;

  @override
  State<DatePick> createState() => _DatePickState();
}

class _DatePickState extends State<DatePick> {
  late DateTime _current;

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
    _current = widget.date;
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
        child: BlocBuilder<AnalyticsBloc, AnalyticsState>(
          builder: (context, state) {
            DateTime current1 = _current;
            DateTime current2 = DateTime(1);

            if (state is AnalyticsCustom) {
              current1 = state.date1;
              if (widget.range) current2 = state.date2;
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.range && current1.year != 1 && current2.year != 1
                            ? '${DateFormat('d MMM yyyy', locale).format(current1)} -\n${DateFormat('d MMM yyyy', locale).format(current2)}'
                            : getMonthYear(_current, locale: locale),
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
                          current1: current1,
                          current2: current2,
                          selected: widget.range
                              ? (date.day == current1.day &&
                                      date.month == current1.month &&
                                      date.year == current1.year) ||
                                  (date.day == current2.day &&
                                      date.month == current2.month &&
                                      date.year == current2.year)
                              : _current == date,
                          onPressed: () {
                            if (widget.range) {
                              context
                                  .read<AnalyticsBloc>()
                                  .add(SelectCustomDate(date: date));
                              logger(date);
                            } else {
                              context.pop(date);
                            }
                          },
                        );
                      }).toList(),
                    );
                  }),
                ),
              ],
            );
          },
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
    required this.current1,
    required this.current2,
    required this.onPressed,
  });

  final DateTime date;
  final DateTime current;
  final DateTime current1;
  final DateTime current2;
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
                color: selected
                    ? colors.accent
                    : date.isAfter(current1) &&
                            date.isBefore(current2) &&
                            current1.year != 1 &&
                            current2.year != 1
                        ? colors.accent.withValues(alpha: 0.2)
                        : null,
                borderRadius: BorderRadius.circular(16),
                border: date.day == now.day &&
                        date.month == now.month &&
                        date.year == now.year
                    ? Border.all(width: 2, color: colors.accent)
                    : null,
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
