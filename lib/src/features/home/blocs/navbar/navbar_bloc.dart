import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(NavbarHome()) {
    on<ChangeNavbar>((event, emit) {
      if (event.id == 1) emit(NavbarHome());
      if (event.id == 2) emit(NavbarAnalytics());
      if (event.id == 3) emit(NavbarAssistant());
      if (event.id == 4) emit(NavbarUtilities());
      if (event.id == 5) emit(NavbarSettings());
    });
  }
}
