class Budget {
  Budget({
    required this.id,
    required this.date,
    required this.limit,
    required this.catID,
    required this.catLimit,
  });

  final int id;
  String date;
  String limit;
  int catID;
  String catLimit;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'limit': limit,
      'catID': catID,
      'catLimit': catLimit,
    };
  }

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'],
      date: map['date'],
      limit: map['limit'],
      catID: map['catID'],
      catLimit: map['catLimit'],
    );
  }
}
