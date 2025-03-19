class Chat {
  Chat({
    required this.id,
    required this.title,
  });

  final int id;
  final String title;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'],
      title: map['title'],
    );
  }
}
