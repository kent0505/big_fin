part of 'utils_bloc.dart';

@immutable
sealed class UtilsEvent {}

final class GetCalcResults extends UtilsEvent {}

final class AddCalcResult extends UtilsEvent {
  AddCalcResult({required this.calc});

  final CalcResult calc;
}

final class EditCalcResult extends UtilsEvent {
  EditCalcResult({required this.calc});

  final CalcResult calc;
}

final class DeleteCalcResults extends UtilsEvent {}
