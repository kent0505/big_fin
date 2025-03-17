part of 'analytics_bloc.dart';

@immutable
sealed class AnalyticsState {}

final class AnalyticsInitial extends AnalyticsState {}

final class AnalyticsCustom extends AnalyticsState {
  AnalyticsCustom({
    required this.date1,
    required this.date2,
  });

  final DateTime date1;
  final DateTime date2;
}
