import 'package:big_fin/src/core/widgets/button.dart';
import 'package:flutter/material.dart';
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
    return ListenableBuilder(
        listenable: _selectTimePeriodicController,
        builder: (context, child) {
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Button(
                    onPressed: () => shiftDate(index, 1),
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
                      shiftDate(index, -1);
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
        _selectTimePeriodicController.changeDay(offset);

      case 1:
        _selectTimePeriodicController.changeMonth(offset);

      case 2:
        _selectTimePeriodicController.changeYear(offset);

      case 3:
        _selectTimePeriodicController.changeDay(offset);
    }
  }

  // --- Formatters --- //

// Weeks
  // String _formatDateRange() {
  //   return '${DateFormat('d MMM').format(_startDate)} - ${DateFormat('d MMM').format(_endDate)}';
  // }

  // String _formatMonth() {
  //   return DateFormat('MMMM yyyy').format(_selectedDate);
  // }

  // String _formatDay() {
  //   return DateFormat('d MMM, yyyy').format(_selectedDate);
  // }

  // DateTime _getStartOfWeek(DateTime date) {
  //   return date.subtract(Duration(days: date.weekday - 1));
  // }

// --- Chage time periodic --- //
}

/// {@template select_time_periodic}
/// SelectTimePeriodicController.
/// {@endtemplate}
final class SelectTimePeriodicController extends ChangeNotifier {
  /// {@macro select_time_periodic}

  DateTime _selectedDate = DateTime.now();

  DateTime _startedTime = DateTime.now(); // For weeks

  DateTime get selectedDate => _selectedDate;

  DateTime get startedTime => _startedTime;

  void changeWeek(int offset) {
    _startedTime = _startedTime.add(Duration(days: 7 * offset));
    _selectedDate = _selectedDate.add(Duration(days: 6));
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
    DateTime now = DateTime.now();
    DateTime nextYear = DateTime(
      now.year + 1,
      now.month,
      now.day,
      now.hour,
      now.minute,
      now.second,
      now.millisecond,
      now.microsecond,
    );

    _selectedDate = nextYear;

    notifyListeners();
  }

  void changeDay(int offset) {
    _selectedDate = _selectedDate.add(Duration(days: offset));
    notifyListeners();
  }
}
