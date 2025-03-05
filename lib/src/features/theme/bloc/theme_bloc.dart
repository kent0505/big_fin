import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/theme_repository.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeRepository _repository;

  ThemeBloc({required ThemeRepository repository})
      : _repository = repository,
        super(ThemeInitial(themeMode: ThemeMode.system)) {
    on<ThemeEvent>(
      (event, emit) => switch (event) {
        GetTheme() => _getTheme(event, emit),
        SetTheme() => _setTheme(event, emit),
      },
    );
  }

  void _getTheme(
    GetTheme event,
    Emitter<ThemeState> emit,
  ) {
    int id = _repository.getTheme();
    if (id == 0) emit(ThemeInitial(themeMode: ThemeMode.system));
    if (id == 1) emit(ThemeInitial(themeMode: ThemeMode.light));
    if (id == 2) emit(ThemeInitial(themeMode: ThemeMode.dark));
  }

  void _setTheme(
    SetTheme event,
    Emitter<ThemeState> emit,
  ) async {
    await _repository.setTheme(event.id);
    add(GetTheme());
  }
}
