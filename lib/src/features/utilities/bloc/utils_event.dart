part of 'utils_bloc.dart';

@immutable
sealed class UtilsEvent {}

final class ChangeUtils extends UtilsEvent {
  ChangeUtils({required this.id});

  final int id;
}

final class SelectTime extends UtilsEvent {
  SelectTime({required this.operatingTime});

  final OperatingTime operatingTime;
}

final class SelectTariff extends UtilsEvent {
  SelectTariff({required this.tariff});

  final Tariff tariff;
}
