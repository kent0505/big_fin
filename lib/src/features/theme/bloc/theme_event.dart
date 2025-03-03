part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

final class GetTheme extends ThemeEvent {}

final class SetTheme extends ThemeEvent {
  SetTheme({required this.id});

  final int id;
}
