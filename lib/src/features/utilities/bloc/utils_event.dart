part of 'utils_bloc.dart';

@immutable
sealed class UtilsEvent {}

final class SelectTime extends UtilsEvent {
  SelectTime({required this.operating});

  final Operating operating;
}

final class SelectTariff extends UtilsEvent {
  SelectTariff({required this.tariff});

  final Tariff tariff;
}
