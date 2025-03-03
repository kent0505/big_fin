part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {
  HomeInitial({
    this.period = Period.monthly,
    required this.date,
    required this.cat,
  });

  final Period period;
  final DateTime date;
  final Cat cat;
}

final class HomeAnalytics extends HomeState {}

final class HomeAssistant extends HomeState {}

final class HomeUtilities extends HomeState {}

final class HomeSettings extends HomeState {}
