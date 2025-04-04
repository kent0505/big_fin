import 'package:flutter/material.dart';

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

  String getTitle(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return {
          'house': l.house,
          'food': l.food,
          'transport': l.transport,
          'family': l.family,
          'health': l.health,
          'shopping': l.shopping,
          'entertainment': l.entertainment,
          'finance_obligations': l.finance,
        }[title] ??
        title;
  }

  Color? getColor() {
    if (colorID == 1) return Color(0xffC028BB);
    if (colorID == 2) return Color(0xffC02846);
    if (colorID == 3) return Color(0xff9228C0);
    if (colorID == 4) return Color(0xff4628C0);
    if (colorID == 5) return Color(0xff289FC0);
    if (colorID == 6) return Color(0xff28C088);
    if (colorID == 7) return Color(0xff28C028);
    if (colorID == 8) return Color(0xffCFD824);
    if (colorID == 9) return Color(0xffD89924);
    if (colorID == 10) return Color(0xffD86024);
    return null;
  }
}

final _colors = MyColors.light();

List<Cat> defaultCats = [
  Cat(id: 1, title: 'house', assetID: 11, indicatorColor: _colors.system),
  Cat(id: 2, title: 'food', assetID: 12, indicatorColor: _colors.orange),
  Cat(id: 3, title: 'transport', assetID: 13, indicatorColor: _colors.blue),
  Cat(id: 4, title: 'family', assetID: 14, indicatorColor: _colors.yellow),
  Cat(id: 5, title: 'health', assetID: 15, indicatorColor: _colors.accent),
  Cat(id: 6, title: 'shopping', assetID: 16, indicatorColor: _colors.shopping),
  Cat(
      id: 7,
      title: 'entertainment',
      assetID: 17,
      indicatorColor: _colors.violet),
  Cat(
      id: 8,
      title: 'finance_obligations',
      assetID: 18,
      indicatorColor: _colors.green),
];

Cat emptyCat = Cat(
  id: 0,
  title: '',
  assetID: -1,
  colorID: -2,
);
