import 'dart:convert';

import 'cat.dart';

class Budget {
  Budget({
    required this.id,
    required this.monthly,
    required this.date,
    required this.amount,
    required this.cats,
  });

  final int id;
  bool monthly;
  String date;
  String amount;
  List<Cat> cats;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'monthly': monthly ? 1 : 0,
      'date': date,
      'amount': amount,
      'cats': jsonEncode(cats.map((cat) => cat.toMap()).toList()),
    };
  }

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'],
      monthly: map['monthly'] == 1,
      date: map['date'],
      amount: map['amount'],
      cats: (jsonDecode(map['cats']) as List)
          .map((catMap) => Cat.fromMap(catMap))
          .toList(),
    );
  }
}
