import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/language_repository.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageRepository _repository;
  LanguageBloc({required LanguageRepository repository})
      : _repository = repository,
        super(LanguageInitial(locale: 'en')) {
    on<GetLanguage>((event, emit) {
      final locale = _repository.getLocale();
      emit(LanguageInitial(locale: locale));
    });

    on<SetLanguage>((event, emit) async {
      await _repository.setLocale(event.locale);
      add(GetLanguage());
    });
  }
}
