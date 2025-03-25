import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dio/dio.dart';

import '../../../core/config/constants.dart';
import '../../../core/models/chat.dart';
import '../../../core/models/message.dart';
import '../../../core/utils.dart';

abstract interface class AssistantRepository {
  const AssistantRepository();

  int getLastUsed();
  int getLimit();
  Future<void> setLimit(int limit);
  Future<List<Chat>> getChats();
  Future<void> deleteChat(Chat chat);
  Future<List<Message>> getMessages(Chat chat);
  Future<void> addChat(Chat chat);
  Future<void> addMessage(Message message);
  Future<String> askGPT(
    String userMessage,
    String locale,
  );
}

final class AssistantRepositoryImpl implements AssistantRepository {
  AssistantRepositoryImpl({
    required SharedPreferences prefs,
    required Database db,
    required Dio dio,
  })  : _prefs = prefs,
        _db = db,
        _dio = dio;

  final SharedPreferences _prefs;
  final Database _db;
  final Dio _dio;

  @override
  int getLastUsed() {
    return _prefs.getInt(Keys.assistantLastUsed) ?? 0;
  }

  @override
  int getLimit() {
    return _prefs.getInt(Keys.assistantDayLimit) ?? 10;
  }

  @override
  Future<void> setLimit(int limit) async {
    await _prefs.setInt(Keys.assistantLastUsed, DateTime.now().day);
    await _prefs.setInt(Keys.assistantDayLimit, limit);
  }

  @override
  Future<List<Chat>> getChats() async {
    final maps = await _db.query(Tables.chats);
    return maps.map((map) => Chat.fromMap(map)).toList();
  }

  @override
  Future<void> deleteChat(Chat chat) async {
    await _db.delete(
      Tables.chats,
      where: 'id = ?',
      whereArgs: [chat.id],
    );
    await _db.delete(
      Tables.messages,
      where: 'chatID = ?',
      whereArgs: [chat.id],
    );
  }

  @override
  Future<List<Message>> getMessages(Chat chat) async {
    final maps = await _db.query(
      Tables.messages,
      where: 'chatID = ?',
      whereArgs: [chat.id],
    );
    return maps.map((map) => Message.fromMap(map)).toList();
  }

  @override
  Future<void> addChat(Chat chat) async {
    await _db.insert(Tables.chats, chat.toMap());
  }

  @override
  Future<void> addMessage(Message message) async {
    await _db.insert(Tables.messages, message.toMap());
  }

  @override
  Future<String> askGPT(
    String userMessage,
    String locale,
  ) async {
    try {
      final instruction =
          'You are a financial assistant. Discuss only finance-related topics. Dont answer to unrelated questions. Keep responses brief. Respond in the same language as the users message or by locale $locale. This is user message:';
      final response = await _dio.post(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${ApiKeys.geminiApiKey}',
        data: {
          'contents': [
            {
              'parts': [
                {'text': '$instruction\n$userMessage'},
              ],
            },
          ],
        },
      );
      logger(response.data);
      return response.data['candidates'][0]['content']['parts'][0]['text'];
    } catch (e) {
      logger('Error: $e');
      return 'Error';
    }
  }
}
