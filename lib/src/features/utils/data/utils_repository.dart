import 'package:sqflite/sqflite.dart';

import '../../../core/config/constants.dart';
import '../../../core/models/calc_result.dart';

abstract interface class UtilsRepository {
  const UtilsRepository();

  Future<List<CalcResult>> getCalcs();
  Future<void> addCalc(CalcResult calc);
  Future<void> editCalc(CalcResult calc);
  Future<void> deleteCalc();
}

final class UtilsRepositoryImpl implements UtilsRepository {
  UtilsRepositoryImpl({required Database db}) : _db = db;

  final Database _db;

  @override
  Future<List<CalcResult>> getCalcs() async {
    final maps = await _db.query(Tables.calcs);
    return maps.map((map) => CalcResult.fromMap(map)).toList();
  }

  @override
  Future<void> addCalc(CalcResult calc) async {
    await _db.insert(Tables.calcs, calc.toMap());
  }

  @override
  Future<void> editCalc(CalcResult calc) async {
    await _db.update(
      Tables.calcs,
      calc.toMap(),
      where: 'id = ?',
      whereArgs: [calc.id],
    );
  }

  @override
  Future<void> deleteCalc() async {
    await _db.delete(Tables.calcs);
  }
}
