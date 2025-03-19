part of 'assistant_bloc.dart';

@immutable
sealed class AssistantState {}

final class AssistantInitial extends AssistantState {}

final class ChatsLoaded extends AssistantState {
  ChatsLoaded({
    required this.chats,
    required this.messages,
    this.loading = false,
  });

  final List<Chat> chats;
  final List<Message> messages;
  final bool loading;
}
