part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

final class GetCategories extends CategoryEvent {}

final class AddCategory extends CategoryEvent {
  AddCategory({required this.cat});

  final Cat cat;
}

final class EditCategory extends CategoryEvent {
  EditCategory({required this.cat});

  final Cat cat;
}

final class DeleteCategory extends CategoryEvent {
  DeleteCategory({required this.cat});

  final Cat cat;
}
