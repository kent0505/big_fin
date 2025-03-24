import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/config/constants.dart';
import '../../../core/models/chat.dart';
import '../../../core/models/message.dart';
import '../../../core/utils.dart';

abstract interface class AssistantRepository {
  const AssistantRepository();

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
    required Database db,
    required Dio dio,
  })  : _db = db,
        _dio = dio;

  final Database _db;
  final Dio _dio;

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
    final apiKey = 'AIzaSyBH3XON-k54dwOdtev-COKmEFJzhhrnBFE'; // gemini
    final instruction =
        'You are a financial assistant. You provide guidance strictly on topics related to personal finance, budgeting, saving, investing, financial planning, and money management. You do not answer questions outside of finance. If asked about unrelated topics, politely redirect the user to financial topics. You should provide clear, well-researched, and practical financial advice while avoiding personal investment recommendations or legal guidance. Your responses should be concise, actionable, and tailored to help individuals or businesses optimize their financial decisions. Answer shortly as it possible. Answer language must be the same with users message, or use language by locale which is $locale if message is not word, for example "Ooo", "123" etc. This is users message:';
    try {
      final response = await _dio.post(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey',
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
      return 'Error: $e';
    }
    // await Future.delayed(Duration(seconds: 2));
    // return '$instruction\n$userMessage';
  }
}
