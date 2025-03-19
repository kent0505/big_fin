import 'package:sqflite/sqflite.dart';

import '../../../core/config/constants.dart';
import '../../../core/models/chat.dart';
import '../../../core/models/message.dart';

abstract interface class AssistantRepository {
  const AssistantRepository();

  Future<List<Chat>> getChats();
  Future<void> deleteChat(Chat chat);
  Future<List<Message>> getMessages(Chat chat);
  Future<void> addChat(Chat chat);
  Future<void> addMessage(Message message);
}

final class AssistantRepositoryImpl implements AssistantRepository {
  AssistantRepositoryImpl({required Database db}) : _db = db;

  final Database _db;

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
    await _db.insert(
      Tables.chats,
      chat.toMap(),
    );
  }

  @override
  Future<void> addMessage(Message message) async {
    await _db.insert(
      Tables.messages,
      message.toMap(),
    );
  }
}
