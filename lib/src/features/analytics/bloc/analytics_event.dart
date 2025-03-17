part of 'analytics_bloc.dart';

@immutable
sealed class AnalyticsEvent {}

final class SelectCustomDate extends AnalyticsEvent {
  SelectCustomDate({required this.date});

  final DateTime date;
}
