part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class DataImported extends SettingsState {}

final class DataImportError extends SettingsState {}

final class DataCleared extends SettingsState {}
