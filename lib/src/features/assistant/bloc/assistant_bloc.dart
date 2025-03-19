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
        LoadMessages() => _loadMessages(event, emit),
        SentMessage() => _sentMessage(event, emit),
        DeleteChat() => _deleteChat(event, emit),
        LoadChats() => _loadChats(event, emit),
      },
    );
  }

  void _loadChats(
    LoadChats event,
    Emitter<AssistantState> emit,
  ) async {
    chats = await _repository.getChats();
    emit(ChatsLoaded(
      chats: chats,
      messages: messages,
    ));
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
    logger(messages.length);
    if (messages.isEmpty) {
      await _repository.addChat(Chat(
        id: event.chat.id,
        title: event.message.message,
      ));
    }
    messages.add(event.message);
    await _repository.addMessage(event.message);
    await _repository.addMessage(Message(
      id: getTimestamp() + 1,
      chatID: event.chat.id,
      message: 'Hello!',
      fromGPT: true,
    ));
    add(LoadMessages(chat: event.chat));
  }

  void _deleteChat(
    DeleteChat event,
    Emitter<AssistantState> emit,
  ) async {
    await _repository.deleteChat(event.chat);
    add(LoadMessages(chat: event.chat));
  }
}
