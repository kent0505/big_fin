part of 'assistant_bloc.dart';

@immutable
sealed class AssistantEvent {}

final class LoadChats extends AssistantEvent {}

final class LoadMessages extends AssistantEvent {
  LoadMessages({required this.chat});

  final Chat chat;
}

final class SentMessage extends AssistantEvent {
  SentMessage({
    required this.chat,
    required this.message,
  });

  final Chat chat;
  final Message message;
}

final class DeleteChat extends AssistantEvent {
  DeleteChat({required this.chat});

  final Chat chat;
}
