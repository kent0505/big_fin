part of 'navbar_bloc.dart';

@immutable
sealed class NavbarState {}

final class NavbarHome extends NavbarState {
  NavbarHome({this.period = Period.monthly});

  final Period period;
}

final class NavbarAnalytics extends NavbarState {}

final class NavbarAssistant extends NavbarState {}

final class NavbarUtilities extends NavbarState {}

final class NavbarSettings extends NavbarState {}
