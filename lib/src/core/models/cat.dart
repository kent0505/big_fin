import 'dart:ui';

class Cat {
  Cat({
    required this.id,
    required this.title,
    required this.assetID,
    this.colorID = 0,
    this.indicatorColor = const Color(0xffffffff),
  });

  final int id;
  String title;
  int assetID;
  int colorID;
  Color indicatorColor;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'assetID': assetID,
      'colorID': colorID,
    };
  }

  factory Cat.fromMap(Map<String, dynamic> map) {
    return Cat(
      id: map['id'],
      title: map['title'],
      assetID: map['assetID'],
      colorID: map['colorID'],
    );
  }
}

List<Cat> defaultCats = [
  Cat(
    id: 1,
    title: 'House',
    assetID: 11,
    indicatorColor: Color(0xffFF3B30),
  ),
  Cat(
    id: 2,
    title: 'Food',
    assetID: 12,
    indicatorColor: Color(0xffFF9500),
  ),
  Cat(
    id: 3,
    title: 'Transport',
    assetID: 13,
    indicatorColor: Color(0xff007AFF),
  ),
  Cat(
    id: 4,
    title: 'Family',
    assetID: 14,
    indicatorColor: Color(0xffD4FF00),
  ),
  Cat(
    id: 5,
    title: 'Health',
    assetID: 15,
    indicatorColor: Color(0xff41FDA9),
  ),
  Cat(
    id: 6,
    title: 'Shopping',
    assetID: 16,
    indicatorColor: Color(0xffFF2D55),
  ),
  Cat(
    id: 7,
    title: 'Entertainment',
    assetID: 17,
    indicatorColor: Color(0xffAF52DE),
  ),
  Cat(
    id: 8,
    title: 'Finance Obligations',
    assetID: 18,
    indicatorColor: Color(0xff34C759),
  ),
];

Cat emptyCat = Cat(
  id: 0,
  title: '',
  assetID: -1,
  colorID: -2,
);
