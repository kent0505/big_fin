import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/calc_result.dart';
import '../data/utils_repository.dart';

part 'utils_event.dart';
part 'utils_state.dart';

class UtilsBloc extends Bloc<UtilsEvent, UtilsState> {
  final UtilsRepository _repository;

  CalcResult selected1 = emptyCalcResult;
  CalcResult selected2 = emptyCalcResult;

  UtilsBloc({required UtilsRepository repository})
      : _repository = repository,
        super(UtilsInitial()) {
    on<UtilsEvent>(
      (event, emit) => switch (event) {
        GetCalcResults() => _getCalcResults(event, emit),
        AddCalcResult() => _addCalcResult(event, emit),
        EditCalcResult() => _editCalcResult(event, emit),
        DeleteCalcResults() => _deleteCalcResult(event, emit),
        SelectCalcResult() => _selectCalcResult(event, emit),
      },
    );
  }

  void _getCalcResults(
    GetCalcResults event,
    Emitter<UtilsState> emit,
  ) async {
    List<CalcResult> calcs = await _repository.getCalcs();
    emit(CalcsLoaded(
      calcs: calcs,
      selected1: selected1,
      selected2: selected2,
    ));
  }

  void _addCalcResult(
    AddCalcResult event,
    Emitter<UtilsState> emit,
  ) async {
    await _repository.addCalc(event.calc);
    add(GetCalcResults());
  }

  void _editCalcResult(
    EditCalcResult event,
    Emitter<UtilsState> emit,
  ) async {
    await _repository.editCalc(event.calc);
    add(GetCalcResults());
  }

  void _deleteCalcResult(
    DeleteCalcResults event,
    Emitter<UtilsState> emit,
  ) async {
    await _repository.deleteCalc();
    add(GetCalcResults());
  }

  void _selectCalcResult(
    SelectCalcResult event,
    Emitter<UtilsState> emit,
  ) {
    if (selected1.id == event.calc.id) {
      selected1 = emptyCalcResult;
    } else if (selected2.id == event.calc.id) {
      selected2 = emptyCalcResult;
    } else if (selected1.id == 0) {
      selected1 = event.calc;
    } else if (selected2.id == 0) {
      selected2 = event.calc;
    } else {
      selected1 = event.calc;
      selected2 = emptyCalcResult;
    }
    add(GetCalcResults());
  }
}
