import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
import '../data/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repository;

  SettingsBloc({required SettingsRepository repository})
      : _repository = repository,
        super(SettingsInitial()) {
    on<SettingsEvent>(
      (event, emit) => switch (event) {
        DownloadData() => _downloadData(event, emit),
        ImportData() => _importData(event, emit),
        ClearData() => _clearData(event, emit),
      },
    );
  }

  void _downloadData(
    DownloadData event,
    Emitter<SettingsState> emit,
  ) async {
    await _repository.downloadData();
    emit(SettingsInitial());
  }

  void _importData(
    ImportData event,
    Emitter<SettingsState> emit,
  ) async {
    bool imported = await _repository.importData();
    emit(imported ? DataImported() : DataImportError());
    emit(SettingsInitial());
    logger(imported ? 'DATA IMPORTED' : 'DATA NOT IMPORTED');
  }

  void _clearData(
    ClearData event,
    Emitter<SettingsState> emit,
  ) async {
    await _repository.clearData();
    emit(DataCleared());
    emit(SettingsInitial());
  }
}
