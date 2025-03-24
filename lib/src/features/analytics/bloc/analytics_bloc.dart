import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  DateTime date1 = DateTime.now();
  DateTime date2 = DateTime(1);

  AnalyticsBloc() : super(AnalyticsInitial()) {
    on<AnalyticsEvent>(
      (event, emit) => switch (event) {
        SelectCustomDate() => _selectCustomDate(event, emit),
      },
    );
  }

  void _selectCustomDate(
    SelectCustomDate event,
    Emitter<AnalyticsState> emit,
  ) {
    if (event.date.year == date1.year &&
        event.date.month == date1.month &&
        event.date.day == date1.day) {
      date1 = DateTime(1);
    } else if (event.date.year == date2.year &&
        event.date.month == date2.month &&
        event.date.day == date2.day) {
      date2 = DateTime(1);
    } else if (date1.year == 1) {
      date1 = event.date;
    } else if (date2.year == 1) {
      date2 = event.date;
    } else if (event.date.isBefore(date1)) {
      date1 = event.date;
    } else if (event.date.isBefore(date2)) {
      date1 = event.date;
    } else {
      date2 = event.date;
    }
    if (date1.year != 1 && date2.year != 1 && date1.isAfter(date2)) {
      final temp = date1;
      date1 = date2;
      date2 = temp;
    }
    logger('date1 = $date1');
    logger('date2 = $date2');
    emit(AnalyticsCustom(
      date1: date1,
      date2: date2,
    ));
  }
}
