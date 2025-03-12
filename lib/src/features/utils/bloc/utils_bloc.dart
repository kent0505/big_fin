import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/calc_result.dart';
import '../data/utils_repository.dart';

part 'utils_event.dart';
part 'utils_state.dart';

class UtilsBloc extends Bloc<UtilsEvent, UtilsState> {
  final UtilsRepository _repository;

  UtilsBloc({required UtilsRepository repository})
      : _repository = repository,
        super(UtilsInitial()) {
    on<UtilsEvent>((event, emit) => switch (event) {
          GetCalcResults() => _getCalcResults(event, emit),
          AddCalcResult() => _addCalcResult(event, emit),
          EditCalcResult() => _editCalcResult(event, emit),
          DeleteCalcResults() => _deleteCalcResult(event, emit),
        });
  }

  void _getCalcResults(
    GetCalcResults event,
    Emitter<UtilsState> emit,
  ) async {
    List<CalcResult> calcs = await _repository.getCalcs();
    emit(CalcsLoaded(calcs: calcs));
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
}
