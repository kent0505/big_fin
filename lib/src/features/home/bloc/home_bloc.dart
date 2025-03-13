import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/enums.dart';
import '../../../core/models/cat.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Period period = Period.monthly;
  DateTime date = DateTime.now();
  Cat cat = emptyCat;

  HomeBloc()
      : super(
          // HomeInitial(cat: emptyCat, date: DateTime.now()),
          HomeAnalytics(),
        ) {
    on<HomeEvent>(
      (event, emit) => switch (event) {
        ChangeHome() => _changeHome(event, emit),
        SortByDate() => _sortByDate(event, emit),
        SortByCategory() => _sortByCategory(event, emit),
      },
    );
  }

  void _changeHome(
    ChangeHome event,
    Emitter<HomeState> emit,
  ) {
    if (event.id == 1) emit(HomeInitial(date: date, cat: cat));
    if (event.id == 2) emit(HomeAnalytics());
    if (event.id == 3) emit(HomeAssistant());
    if (event.id == 4) emit(HomeUtilities());
    if (event.id == 5) emit(HomeSettings());
  }

  void _sortByDate(
    SortByDate event,
    Emitter<HomeState> emit,
  ) {
    date = event.date;
    emit(HomeInitial(date: date, cat: cat));
  }

  void _sortByCategory(
    SortByCategory event,
    Emitter<HomeState> emit,
  ) {
    cat = event.cat;
    emit(HomeInitial(date: date, cat: cat));
  }
}
