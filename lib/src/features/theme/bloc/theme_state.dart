part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {
  ThemeInitial({required this.themeMode});

  final ThemeMode themeMode;
}
