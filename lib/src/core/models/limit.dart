import 'cat.dart';

class Limit {
  Limit({
    required this.month,
    required this.date,
    required this.cats,
  });

  final bool month;
  final String date;
  final List<Cat> cats;
}
