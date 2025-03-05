part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class ChangeHome extends HomeEvent {
  ChangeHome({required this.id});

  final int id;
}

final class ChangePeriod extends HomeEvent {
  ChangePeriod({required this.period});

  final Period period;
}

final class SortByDate extends HomeEvent {
  SortByDate({required this.date});

  final DateTime date;
}

final class SortByCategory extends HomeEvent {
  SortByCategory({required this.cat});

  final Cat cat;
}
