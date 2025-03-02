import 'package:sqflite/sqflite.dart';

import '../../../core/config/constants.dart';
import '../models/expense.dart';

abstract interface class ExpenseRepository {
  const ExpenseRepository();

  Future<List<Expense>> getExpenses();
  Future<void> addExpense(Expense expense);
  Future<void> editExpense(Expense expense);
  Future<void> deleteExpense(Expense expense);
}

final class ExpenseRepositoryImpl implements ExpenseRepository {
  ExpenseRepositoryImpl({required Database db}) : _db = db;

  final Database _db;

  @override
  Future<List<Expense>> getExpenses() async {
    final maps = await _db.query(Keys.expensesTable);
    return maps.map((map) => Expense.fromMap(map)).toList();
  }

  @override
  Future<void> addExpense(Expense expense) async {
    await _db.insert(
      Keys.expensesTable,
      expense.toMap(),
    );
  }

  @override
  Future<void> editExpense(Expense expense) async {
    await _db.update(
      Keys.expensesTable,
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  @override
  Future<void> deleteExpense(Expense expense) async {
    await _db.delete(
      Keys.expensesTable,
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }
}
