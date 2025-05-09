class Expense {
  Expense({
    required this.id,
    required this.date,
    required this.time,
    required this.title,
    required this.amount,
    required this.note,
    required this.attachment1,
    required this.attachment2,
    required this.attachment3,
    required this.catID,
    required this.isIncome,
  });

  final int id;
  final String date;
  final String time;
  final String title;
  final String amount;
  final String note;
  final String attachment1;
  final String attachment2;
  final String attachment3;
  final int catID;
  final bool isIncome;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'time': time,
      'title': title,
      'amount': amount,
      'note': note,
      'attachment1': attachment1,
      'attachment2': attachment2,
      'attachment3': attachment3,
      'catID': catID,
      'isIncome': isIncome ? 1 : 0,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      date: map['date'],
      time: map['time'],
      title: map['title'],
      amount: map['amount'],
      note: map['note'],
      attachment1: map['attachment1'],
      attachment2: map['attachment2'],
      attachment3: map['attachment3'],
      catID: map['catID'],
      isIncome: map['isIncome'] == 1,
    );
  }
}
