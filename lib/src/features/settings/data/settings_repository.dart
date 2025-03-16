import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/utils.dart';

abstract interface class SettingsRepository {
  const SettingsRepository();

  Future<void> downloadData();
  Future<void> importData();
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
  Future<void> importData() async {
    // try {
    //   FilePickerResult? result = await FilePicker.platform.pickFiles(
    //     type: FileType.any,
    //   );
    //   if (result == null || result.files.single.path == null) return;
    //   final file = File(result.files.single.path!);
    //   if (!file.path.endsWith('.db')) {
    //     logger('Invalid file type. Please select a .db file.');
    //     return;
    //   }
    // } on Object catch (e) {
    //   logger(e);
    // }
  }
}
