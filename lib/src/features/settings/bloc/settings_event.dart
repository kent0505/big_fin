part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

final class DownloadData extends SettingsEvent {}

final class ImportData extends SettingsEvent {}
