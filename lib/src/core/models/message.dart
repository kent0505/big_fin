class Message {
  Message({
    required this.id,
    required this.chatID,
    required this.message,
    required this.fromGPT,
  });

  final int id;
  final int chatID;
  final String message;
  final bool fromGPT;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chatID': chatID,
      'message': message,
      'fromGPT': fromGPT ? 1 : 0,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      chatID: map['chatID'],
      message: map['message'],
      fromGPT: map['fromGPT'] == 1,
    );
  }
}
