import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/category_repository.dart';
import '../models/cat.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _repository;

  CategoryBloc({required CategoryRepository repository})
      : _repository = repository,
        super(CategoryInitial()) {
    on<CategoryEvent>(
      (event, emit) => switch (event) {
        GetCategories() => _getCategories(event, emit),
        AddCategory() => _addCategory(event, emit),
        EditCategory() => _editCategory(event, emit),
        DeleteCategory() => _deleteCategory(event, emit),
      },
    );
  }

  void _getCategories(
    GetCategories event,
    Emitter<CategoryState> emit,
  ) async {
    List<Cat> categories = await _repository.getCategories();
    emit(CategoriesLoaded(
      categories: categories.reversed.toList() + defaultCats,
    ));
  }

  void _addCategory(
    AddCategory event,
    Emitter<CategoryState> emit,
  ) async {
    await _repository.addCategory(event.cat);
    add(GetCategories());
  }

  void _editCategory(
    EditCategory event,
    Emitter<CategoryState> emit,
  ) async {
    await _repository.editCategory(event.cat);
    add(GetCategories());
  }

  void _deleteCategory(
    DeleteCategory event,
    Emitter<CategoryState> emit,
  ) async {
    await _repository.deleteCategory(event.cat);
    add(GetCategories());
  }
}
