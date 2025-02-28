import 'package:sqflite/sqflite.dart';

import '../../../core/config/constants.dart';
import '../../../core/utils.dart';
import '../models/cat.dart';

abstract interface class CategoryRepository {
  const CategoryRepository();

  Future<List<Cat>> getCategories();
  Future<void> addCategory(Cat cat);
  Future<void> editCategory(Cat cat);
  Future<void> deleteCategory(Cat cat);
}

final class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({required Database db}) : _db = db;

  final Database _db;

  @override
  Future<List<Cat>> getCategories() async {
    final maps = await _db.query(Keys.categoriesTable);
    return maps.map((map) => Cat.fromMap(map)).toList();
  }

  @override
  Future<void> addCategory(Cat cat) async {
    try {
      await _db.insert(
        Keys.categoriesTable,
        cat.toMap(),
      );
    } on Object catch (e) {
      logger(e);
    }
  }

  @override
  Future<void> editCategory(Cat cat) async {
    try {
      await _db.update(
        Keys.categoriesTable,
        cat.toMap(),
        where: 'id = ?',
        whereArgs: [cat.id],
      );
    } on Object catch (e) {
      logger(e);
    }
  }

  @override
  Future<void> deleteCategory(Cat cat) async {
    await _db.delete(
      Keys.categoriesTable,
      where: 'id = ?',
      whereArgs: [cat.id],
    );
  }
}
