part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoriesLoaded extends CategoryState {
  CategoriesLoaded({required this.categories});

  final List<Cat> categories;
}
