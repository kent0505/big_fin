import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/enums.dart';
import '../../category/models/cat.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Period period = Period.monthly;
  Cat cat = emptyCat;

  HomeBloc() : super(HomeInitial(cat: emptyCat)) {
    on<ChangeHome>((event, emit) {
      if (event.id == 1) emit(HomeInitial(period: period, cat: cat));
      if (event.id == 2) emit(HomeAnalytics());
      if (event.id == 3) emit(HomeAssistant());
      if (event.id == 4) emit(HomeUtilities());
      if (event.id == 5) emit(HomeSettings());
    });

    on<ChangePeriod>((event, emit) {
      period = event.period;
      emit(HomeInitial(
        period: period,
        cat: cat,
      ));
    });

    on<SortByCategory>((event, emit) {
      cat = event.cat;
      emit(HomeInitial(
        period: period,
        cat: cat,
      ));
    });
  }
}
