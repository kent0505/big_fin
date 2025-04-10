import 'package:sqflite/sqflite.dart';

import '../../../core/config/constants.dart';
import '../../../core/models/cat.dart';

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
    final maps = await _db.query(Tables.categories);
    return maps.map((map) => Cat.fromMap(map)).toList();
  }

  @override
  Future<void> addCategory(Cat cat) async {
    await _db.insert(
      Tables.categories,
      cat.toMap(),
    );
  }

  @override
  Future<void> editCategory(Cat cat) async {
    await _db.update(
      Tables.categories,
      cat.toMap(),
      where: 'id = ?',
      whereArgs: [cat.id],
    );
  }

  @override
  Future<void> deleteCategory(Cat cat) async {
    await _db.delete(
      Tables.categories,
      where: 'id = ?',
      whereArgs: [cat.id],
    );
  }
}
