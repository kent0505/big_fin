class Expense {
  Expense({
    required this.id,
    required this.date,
    required this.time,
    required this.title,
    required this.amount,
    required this.categoryID,
    required this.note,
  });

  final int id;
  final String date;
  final String time;
  final String title;
  final String amount;
  final int categoryID;
  final String note;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'time': time,
      'title': title,
      'amount': amount,
      'categoryID': categoryID,
      'note': note,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      date: map['date'],
      time: map['time'],
      title: map['title'],
      amount: map['amount'],
      categoryID: map['categoryID'],
      note: map['note'],
    );
  }
}
