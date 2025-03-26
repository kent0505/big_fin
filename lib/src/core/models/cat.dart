import 'dart:ui';

import '../config/my_colors.dart';

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

final _colors = MyColors.light();

List<Cat> defaultCats = [
  Cat(id: 1, title: 'House', assetID: 11, indicatorColor: _colors.system),
  Cat(id: 2, title: 'Food', assetID: 12, indicatorColor: _colors.orange),
  Cat(id: 3, title: 'Transport', assetID: 13, indicatorColor: _colors.blue),
  Cat(id: 4, title: 'Family', assetID: 14, indicatorColor: _colors.yellow),
  Cat(id: 5, title: 'Health', assetID: 15, indicatorColor: _colors.accent),
  Cat(id: 6, title: 'Shopping', assetID: 16, indicatorColor: _colors.shopping),
  Cat(
      id: 7,
      title: 'Entertainment',
      assetID: 17,
      indicatorColor: _colors.violet),
  Cat(
      id: 8,
      title: 'Finance Obligations',
      assetID: 18,
      indicatorColor: _colors.green),
];

Cat emptyCat = Cat(
  id: 0,
  title: '',
  assetID: -1,
  colorID: -2,
);
