part of 'language_bloc.dart';

@immutable
sealed class LanguageEvent {}

final class GetLanguage extends LanguageEvent {}

final class SetLanguage extends LanguageEvent {
  SetLanguage({required this.locale});

  final String locale;
}
