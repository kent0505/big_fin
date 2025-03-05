import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/enums.dart';

part 'utils_event.dart';
part 'utils_state.dart';

class UtilsBloc extends Bloc<UtilsEvent, UtilsState> {
  OperatingTime operatingTime = OperatingTime.hours;
  Tariff tariff = Tariff.usd;

  UtilsBloc()
      : super(UtilsInitial(
          operatingTime: OperatingTime.hours,
          tariff: Tariff.usd,
        )) {
    on<UtilsEvent>(
      (event, emit) => switch (event) {
        ChangeUtils() => _changeUtils(event, emit),
        SelectTime() => _selectTime(event, emit),
        SelectTariff() => _selectTariff(event, emit),
      },
    );
  }

  void _changeUtils(
    ChangeUtils event,
    Emitter<UtilsState> emit,
  ) {
    if (event.id == 1) {
      emit(UtilsInitial(
        operatingTime: operatingTime,
        tariff: tariff,
      ));
    }
    if (event.id == 2) emit(UtilsComparison());
    if (event.id == 3) emit(UtilsNews());
  }

  void _selectTime(
    SelectTime event,
    Emitter<UtilsState> emit,
  ) {
    operatingTime = event.operatingTime;
    emit(UtilsInitial(
      operatingTime: operatingTime,
      tariff: tariff,
    ));
  }

  void _selectTariff(
    SelectTariff event,
    Emitter<UtilsState> emit,
  ) {
    tariff = event.tariff;
    emit(UtilsInitial(
      operatingTime: operatingTime,
      tariff: tariff,
    ));
  }
}
