import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/expense.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../expense/bloc/expense_bloc.dart';
import '../../expense/screens/add_expense_screen.dart';
import '../../language/bloc/language_bloc.dart';
import '../../settings/data/settings_repository.dart';
import '../bloc/analytics_bloc.dart';

class AnalyticsCalendarScreen extends StatefulWidget {
  const AnalyticsCalendarScreen({super.key});

  static const routePath = '/AnalyticsCalendarScreen';

  @override
  State<AnalyticsCalendarScreen> createState() =>
      _AnalyticsCalendarScreenState();
}

class _AnalyticsCalendarScreenState extends State<AnalyticsCalendarScreen> {
  late DateTime _current;
  String locale = Locales.defaultLocale;
  String currency = Currencies.usd;

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
    _current = DateTime.now();
    locale = context.read<LanguageBloc>().state.languageCode;
    currency = context.read<SettingsRepository>().getCurrency();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: Appbar(),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<AnalyticsBloc, AnalyticsState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 16),
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
                    const SizedBox(width: 8),
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
                      children: _getWeek(_current, weekIndex).map(
                        (date) {
                          return _Day(
                            date: date,
                            current: _current,
                            currency: currency,
                            onPressed: () {
                              context.push(
                                AddExpenseScreen.routePath,
                                extra: date,
                              );
                            },
                          );
                        },
                      ).toList(),
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
    required this.currency,
    required this.onPressed,
  });

  final DateTime date;
  final DateTime current;
  final String currency;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final state = context.watch<ExpenseBloc>().state;

    double x = 0;
    double y = 0;

    if (state is ExpensesLoaded) {
      for (Expense expense in state.expenses) {
        DateTime parsed = stringToDate(expense.date);
        if (parsed.year == date.year &&
            parsed.month == date.month &&
            parsed.day == date.day) {
          expense.isIncome
              ? x += tryParseDouble(expense.amount)
              : y += tryParseDouble(expense.amount);
        }
      }
    }

    return Expanded(
      child: Column(
        children: [
          Button(
            onPressed: onPressed,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                    color: date.month == current.month
                        ? colors.textPrimary
                        : colors.tertiaryFour,
                    fontSize: 16,
                    fontFamily: AppFonts.bold,
                  ),
                ),
              ),
            ),
          ),
          _Amount(
            amount: x,
            isIncome: true,
            currency: currency,
          ),
          _Amount(
            amount: y,
            isIncome: false,
            currency: currency,
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

    return Expanded(
      child: SizedBox(
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
      ),
    );
  }
}

class _Amount extends StatelessWidget {
  const _Amount({
    required this.amount,
    required this.isIncome,
    required this.currency,
  });

  final double amount;
  final bool isIncome;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Text(
      amount == 0 ? '' : '$currency${amount.toStringAsFixed(2)}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: isIncome ? colors.accent : colors.system,
        fontSize: 10,
        fontFamily: AppFonts.medium,
      ),
    );
  }
}
