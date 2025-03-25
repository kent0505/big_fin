import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/chat.dart';
import '../../../core/models/message.dart';
import '../../../core/utils.dart';
import '../data/assistant_repository.dart';

part 'assistant_event.dart';
part 'assistant_state.dart';

class AssistantBloc extends Bloc<AssistantEvent, AssistantState> {
  final AssistantRepository _repository;
  List<Chat> chats = [];
  List<Message> messages = [];

  AssistantBloc({required AssistantRepository repository})
      : _repository = repository,
        super(AssistantInitial()) {
    on<AssistantEvent>(
      (event, emit) => switch (event) {
        LoadChats() => _loadChats(event, emit),
        DeleteChat() => _deleteChat(event, emit),
        LoadMessages() => _loadMessages(event, emit),
        SentMessage() => _sentMessage(event, emit),
      },
    );
  }

  void _loadChats(
    LoadChats event,
    Emitter<AssistantState> emit,
  ) async {
    // СБРОСИТЬ ЛИМИТ АССИСТЕНТА
    int now = DateTime.now().day;
    int lastUsed = _repository.getLastUsed();
    if (lastUsed != now) await _repository.setLimit(10);

    chats = await _repository.getChats();
    emit(ChatsLoaded(
      chats: chats,
      messages: messages,
    ));
  }

  void _deleteChat(
    DeleteChat event,
    Emitter<AssistantState> emit,
  ) async {
    await _repository.deleteChat(event.chat);
    add(LoadMessages(chat: event.chat));
  }

  void _loadMessages(
    LoadMessages event,
    Emitter<AssistantState> emit,
  ) async {
    chats = await _repository.getChats();
    messages = await _repository.getMessages(event.chat);
    emit(ChatsLoaded(
      chats: chats,
      messages: messages,
    ));
  }

  void _sentMessage(
    SentMessage event,
    Emitter<AssistantState> emit,
  ) async {
    // ЕСЛИ ЭТО НОВЫЙ ЧАТ ТО СОХРАНЯЕТ В БД
    if (messages.isEmpty) {
      await _repository.addChat(Chat(
        id: event.chat.id,
        title: event.message.message,
      ));
    }

    // СООБЩЕНИЕ ОТ ПОЛЬЗОВАТЕЛЯ
    await _repository.addMessage(event.message);
    messages.add(event.message);

    // ДОБАВИТЬ СООБЩЕНИЕ ЗАГРУЗКИ
    messages.add(Message(
      id: 0,
      chatID: 0,
      message: '',
      fromGPT: true,
    ));

    emit(ChatsLoaded(
      chats: chats,
      messages: messages,
      loading: true,
    ));

    // ПОЛУЧИТЬ КОЛИЧЕСТВО ЛИМИТА
    int limit = _repository.getLimit();
    logger(limit);
    String message = '';

    if (limit == 0) {
      message = 'Daily limit reached!';
    } else {
      limit--;
      await _repository.setLimit(limit);

      // СООБЩЕНИЕ ОТ GPT
      message = await _repository.askGPT(
        event.message.message,
        event.locale,
      );
    }

    final model = Message(
      id: getTimestamp(),
      chatID: event.chat.id,
      message: message,
      fromGPT: true,
    );
    await _repository.addMessage(model);
    messages.removeLast(); // УБРАТЬ СООБЩЕНИЕ ЗАГРУЗКИ
    messages.add(model);
    emit(ChatsLoaded(
      chats: chats,
      messages: messages,
      loading: true,
    ));
  }
}
