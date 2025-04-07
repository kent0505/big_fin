class Budget {
  Budget({
    required this.id,
    required this.monthly,
    required this.date,
    required this.amount,
  });

  final int id;
  bool monthly;
  String date;
  String amount;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'monthly': monthly ? 1 : 0,
      'date': date,
      'amount': amount,
    };
  }

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'],
      monthly: map['monthly'] == 1,
      date: map['date'],
      amount: map['amount'],
    );
  }
}
