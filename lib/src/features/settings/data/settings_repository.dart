import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/utils.dart';

abstract interface class SettingsRepository {
  const SettingsRepository();

  Future<void> downloadData();
  Future<bool> importData();
}

final class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({
    required Database db,
    required String path,
  })  : _db = db,
        _path = path;

  final Database _db;
  final String _path;

  @override
  Future<void> downloadData() async {
    logger('DOWNLOAD DATA');
    try {
      await Share.shareXFiles(
        [XFile(_path)],
        text: 'Here is your database backup.',
      );
    } on Object catch (e) {
      logger(e);
    }
  }

  @override
  Future<bool> importData() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );
      if (result == null || result.files.single.path == null) return false;
      final file = File(result.files.single.path!);
      if (!file.path.endsWith('.db')) {
        logger('Invalid file type. Please select a .db file.');
        return false;
      }
      return await _compareDatabases(_db, file.path);
    } on Object catch (e) {
      logger(e);
      return false;
    }
  }

  Future<bool> _compareDatabases(Database db1, String path2) async {
    try {
      // ОТКРЫВАЕТ ИМПОРТИРОВАННЫЙ БД, ОСНОВНОЙ БД УЖЕ ОТКРЫТ
      Database db2 = await openDatabase(path2);

      List<Map<String, dynamic>> tables1 = await db1.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'",
      );
      List<Map<String, dynamic>> tables2 = await db2.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'",
      );

      // ПОЛУЧАЕТ НАЗВАНИЯ ТАБЛИЦ
      List<String> tableNames1 =
          tables1.map((e) => e['name'] as String).toList();
      List<String> tableNames2 =
          tables2.map((e) => e['name'] as String).toList();

      // СРАВНИВАЕТ НАЗВАНИЯ ТАБЛИЦ
      if (tableNames1.toString() == tableNames2.toString()) {
        List<String> columns1 = [];
        List<String> columns2 = [];

        // ПОЛУЧАЕТ ИНФОРМАЦИЮ О КАЖДОЙ ТАБЛИЦЕ
        for (String table in tableNames1) {
          List<Map<String, dynamic>> columns = await db1.rawQuery(
            "PRAGMA table_info($table)",
          );
          columns1.add(columns.toString());
        }
        for (String table in tableNames2) {
          List<Map<String, dynamic>> columns = await db2.rawQuery(
            "PRAGMA table_info($table)",
          );
          columns2.add(columns.toString());
        }

        // СРАВНИВАЕТ ИНФОРМАЦИИ
        if (columns1.toString() == columns2.toString()) {
          logger('COLUMNS ARE THE SAME');

          // ДОБАВЛЯЕТ ДАННЫЕ ИЗ ВТОРОЙ БД В ОСНОВНУЮ
          for (String table in tableNames1) {
            List<Map<String, dynamic>> rows = await db2.rawQuery(
              "SELECT * FROM $table",
            );

            for (Map<String, dynamic> row in rows) {
              // ПОКА ЧТО ДОБАВЛЯЕТ ВСЕ ДАННЫЕ ДАЖЕ ЕСЛИ ОНИ УЖЕ СУЩЕСТВУЮТ В ОСНОВНОМ БД
              await db1.insert(
                table,
                row,
                conflictAlgorithm: ConflictAlgorithm.ignore,
              );
            }
          }
        } else {
          logger('COLUMNS ARE DIFFERENT');
          return false;
        }
      } else {
        logger('TABLES ARE DIFFERENT');
        logger(tableNames1);
        logger(tableNames2);
        return false;
      }
      await db2.close();
      return true;
    } on Object catch (e) {
      logger(e);
      return false;
    }
  }
}
