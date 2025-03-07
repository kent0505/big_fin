import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/enums.dart';

part 'utils_event.dart';
part 'utils_state.dart';

class UtilsBloc extends Bloc<UtilsEvent, UtilsState> {
  Operating operating = Operating.hours;
  Tariff tariff = Tariff.usd;

  UtilsBloc() : super(UtilsInitial()) {
    on<UtilsEvent>(
      (event, emit) => switch (event) {
        SelectTime() => _selectTime(event, emit),
        SelectTariff() => _selectTariff(event, emit),
      },
    );
  }

  void _selectTime(
    SelectTime event,
    Emitter<UtilsState> emit,
  ) {
    operating = event.operating;
    emit(UtilsInitial(
      operating: operating,
      tariff: tariff,
    ));
  }

  void _selectTariff(
    SelectTariff event,
    Emitter<UtilsState> emit,
  ) {
    tariff = event.tariff;
    emit(UtilsInitial(
      operating: operating,
      tariff: tariff,
    ));
  }
}
