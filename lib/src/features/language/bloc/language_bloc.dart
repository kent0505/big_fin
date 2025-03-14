import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/language_repository.dart';

part 'language_event.dart';

class LanguageBloc extends Bloc<LanguageEvent, Locale> {
  final LanguageRepository _repository;

  LanguageBloc({required LanguageRepository repository})
      : _repository = repository,
        super(Locale('en')) {
    on<LanguageEvent>(
      (event, emit) => switch (event) {
        GetLanguage() => _getLanguage(event, emit),
        SetLanguage() => _setLanguage(event, emit),
      },
    );
  }

  void _getLanguage(
    GetLanguage event,
    Emitter<Locale> emit,
  ) {
    final locale = _repository.getLocale();
    emit(Locale(locale));
  }

  void _setLanguage(
    SetLanguage event,
    Emitter<Locale> emit,
  ) async {
    await _repository.setLocale(event.locale);
    add(GetLanguage());
  }
}
