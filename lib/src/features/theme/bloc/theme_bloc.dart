import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/theme_repository.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  final ThemeRepository _repository;

  ThemeBloc({required ThemeRepository repository})
      : _repository = repository,
        super(ThemeMode.dark) {
    on<ThemeEvent>(
      (event, emit) => switch (event) {
        GetTheme() => _getTheme(event, emit),
        SetTheme() => _setTheme(event, emit),
      },
    );
  }

  void _getTheme(
    GetTheme event,
    Emitter<ThemeMode> emit,
  ) {
    int id = _repository.getTheme();
    if (id == 0) emit(ThemeMode.system);
    if (id == 1) emit(ThemeMode.light);
    if (id == 2) emit(ThemeMode.dark);
  }

  void _setTheme(
    SetTheme event,
    Emitter<ThemeMode> emit,
  ) async {
    await _repository.setTheme(event.id);
    add(GetTheme());
  }
}
