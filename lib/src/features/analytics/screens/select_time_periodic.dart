import 'package:big_fin/src/core/widgets/button.dart';
import 'package:big_fin/src/features/language/bloc/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/svg_widget.dart';

/// {@template time_periodic_widget}
/// SelectTimePeriodicWidget widget.
/// {@endtemplate}
class SelectTimePeriodicWidget extends StatefulWidget {
  /// {@macro time_periodic_widget}
  const SelectTimePeriodicWidget({
    required this.timePeriodIndex,
    super.key, // ignore: unused_element
  });

  final int timePeriodIndex;

  @override
  State<SelectTimePeriodicWidget> createState() =>
      SelectTimePeriodicWidgetState();
}

/// State for widget SelectTimePeriodicWidget.
class SelectTimePeriodicWidgetState extends State<SelectTimePeriodicWidget> {
  final _selectTimePeriodicController = SelectTimePeriodicController();
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(covariant SelectTimePeriodicWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The configuration of InheritedWidgets has changed
    // Also called after initState but before build
  }

  @override
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final index = widget.timePeriodIndex;

    final locale = context.watch<LanguageBloc>().state.languageCode;
    return ListenableBuilder(
        listenable: _selectTimePeriodicController,
        builder: (context, child) {
          final selectedDate = _selectTimePeriodicController.selectedDate;
          final startedDate = _selectTimePeriodicController.startedDate;
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Button(
                    onPressed: () => shiftDate(index, -1),
                    child: SvgWidget(
                      Assets.back,
                      color: colors.textPrimary,
                    ),
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        key: ValueKey(widget.timePeriodIndex),
                        switch (index) {
                          == 0 => _formatDateRange(selectedDate, startedDate,locale),
                          == 1 => _formatMonth(selectedDate,locale),
                          == 2 => '${selectedDate.year}',
                          == 3 => _formatDay(selectedDate,locale),
                          _ => '',
                        },
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 14,
                          fontFamily: AppFonts.medium,
                        ),
                      ),
                    ),
                  ),
                  Button(
                    onPressed: () {
                      shiftDate(index, 1);
                    },
                    child: SvgWidget(
                      Assets.right,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  void shiftDate(int index, int offset) {
    switch (index) {
      case 0:
        _selectTimePeriodicController.changeWeek(offset);

      case 1:
        _selectTimePeriodicController.changeMonth(offset);

      case 2:
        _selectTimePeriodicController.changeYear(offset);

      case 3:
        _selectTimePeriodicController.changeDay(offset);
    }
  }

  // --- Formatters --- //

  String _formatDateRange(DateTime startDate, DateTime endDate, String locale) {
    return '${DateFormat('d MMM', locale).format(startDate)} - ${DateFormat('d MMM',locale).format(endDate)}';
  }

  String _formatMonth(DateTime selectedDate, String locale) {
    return DateFormat('MMMM yyyy', locale).format(selectedDate);
  }

  String _formatDay(DateTime selectedDate, String locale) {
    return DateFormat('d MMM, yyyy', locale).format(selectedDate).replaceAll('.', '');
  }
}

/// {@template select_time_periodic}
/// SelectTimePeriodicController.
/// {@endtemplate}
final class SelectTimePeriodicController extends ChangeNotifier {
  /// {@macro select_time_periodic}
  DateTime _selectedDate = DateTime.now();
  DateTime _startedDate =
      _getStartOfWeek(DateTime.now()); // Корректный старт недели

  DateTime get selectedDate => _selectedDate;
  DateTime get startedDate => _startedDate;

  void changeWeek(int offset) {
    _startedDate = _startedDate.add(Duration(days: 7)); // Сдвиг недели
    _selectedDate = _startedDate
        .add(Duration(days: 6)); // Устанавливаем дату на начало недели
    notifyListeners();
  }

  void changeMonth(int offset) {
    _selectedDate = DateTime(
      _selectedDate.year,
      _selectedDate.month + offset,
    );
    notifyListeners();
  }

  void changeYear(int offset) {
    _selectedDate = DateTime(
      _selectedDate.year + offset, // Теперь корректно увеличивает или уменьшает
      _selectedDate.month,
      _selectedDate.day,
    );
    notifyListeners();
  }

  void changeDay(int offset) {
    _selectedDate = _selectedDate.add(Duration(days: offset));
    notifyListeners();
  }

  static DateTime _getStartOfWeek(DateTime date) {
    int daysToSubtract = date.weekday - DateTime.monday;
    return date.subtract(Duration(days: daysToSubtract));
  }
}
