class Expense {
  Expense({
    required this.id,
    required this.date,
    required this.time,
    required this.title,
    required this.amount,
    required this.note,
    required this.catTitle,
    required this.assetID,
    required this.colorID,
    required this.isIncome,
  });

  final int id;
  final String date;
  final String time;
  final String title;
  final String amount;
  final String note;
  final String catTitle;
  final int assetID;
  final int colorID;
  final bool isIncome;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'time': time,
      'title': title,
      'amount': amount,
      'note': note,
      'catTitle': catTitle,
      'assetID': assetID,
      'colorID': colorID,
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
      catTitle: map['catTitle'],
      assetID: map['assetID'],
      colorID: map['colorID'],
      isIncome: map['isIncome'] == 1,
    );
  }
}
