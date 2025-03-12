part of 'utils_bloc.dart';

@immutable
sealed class UtilsState {}

final class UtilsInitial extends UtilsState {}

final class CalcsLoaded extends UtilsState {
  CalcsLoaded({required this.calcs});

  final List<CalcResult> calcs;
}
