import 'package:sqflite/sqflite.dart';

import '../../../core/config/constants.dart';
import '../../../core/models/budget.dart';

abstract interface class BudgetRepository {
  const BudgetRepository();

  Future<List<Budget>> getBudgets();
  Future<void> addBudget(Budget budget);
  Future<void> editBudget(Budget budget);
  Future<void> deleteBudget(Budget budget);
}

final class BudgetRepositoryImpl implements BudgetRepository {
  BudgetRepositoryImpl({required Database db}) : _db = db;

  final Database _db;

  @override
  Future<List<Budget>> getBudgets() async {
    final maps = await _db.query(Tables.budgets);
    return maps.map((map) => Budget.fromMap(map)).toList();
  }

  @override
  Future<void> addBudget(Budget budget) async {
    await _db.insert(
      Tables.budgets,
      budget.toMap(),
    );
  }

  @override
  Future<void> editBudget(Budget budget) async {
    await _db.update(
      Tables.budgets,
      budget.toMap(),
      where: 'id = ?',
      whereArgs: [budget.id],
    );
  }

  @override
  Future<void> deleteBudget(Budget budget) async {
    await _db.delete(
      Tables.budgets,
      where: 'id = ?',
      whereArgs: [budget.id],
    );
  }
}
