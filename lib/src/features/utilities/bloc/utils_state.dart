part of 'utils_bloc.dart';

@immutable
sealed class UtilsState {}

final class UtilsInitial extends UtilsState {
  UtilsInitial({
    required this.operatingTime,
    required this.tariff,
  });

  final OperatingTime operatingTime;
  final Tariff tariff;
}

final class UtilsComparison extends UtilsState {}

final class UtilsNews extends UtilsState {}
