part of 'utils_bloc.dart';

@immutable
sealed class UtilsState {}

final class UtilsInitial extends UtilsState {
  UtilsInitial({
    this.operating = Operating.hours,
    this.tariff = Tariff.usd,
  });

  final Operating operating;
  final Tariff tariff;
}
