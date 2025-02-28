part of 'navbar_bloc.dart';

@immutable
sealed class NavbarEvent {}

class ChangeNavbar extends NavbarEvent {
  ChangeNavbar({required this.id});

  final int id;
}
