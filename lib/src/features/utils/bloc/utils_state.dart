part of 'utils_bloc.dart';

@immutable
sealed class UtilsState {}

final class UtilsInitial extends UtilsState {}

final class CalcsLoaded extends UtilsState {
  CalcsLoaded({
    required this.calcs,
    required this.selected1,
    required this.selected2,
  });

  final List<CalcResult> calcs;
  final CalcResult selected1;
  final CalcResult selected2;
}
