part of 'language_bloc.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitial extends LanguageState {
  LanguageInitial({required this.locale});

  final String locale;
}
