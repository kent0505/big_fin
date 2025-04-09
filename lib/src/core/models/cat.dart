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
          '1': l.house,
          '2': l.food,
          '3': l.transport,
          '4': l.family,
          '5': l.health,
          '6': l.shopping,
          '7': l.entertainment,
          '8': l.finance,
          '9': l.beauty,
          '10': l.gifts,
          '11': l.education,
          '12': l.salary,
          '13': l.dividents,
          '14': l.business,
          '15': l.bonus,
          '16': l.other,
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

List<Cat> expenseCats = [
  Cat(id: 1, title: '1', assetID: 11, indicatorColor: _colors.system),
  Cat(id: 2, title: '2', assetID: 12, indicatorColor: _colors.orange),
  Cat(id: 3, title: '3', assetID: 13, indicatorColor: _colors.blue),
  Cat(id: 4, title: '4', assetID: 14, indicatorColor: _colors.yellow),
  Cat(id: 5, title: '5', assetID: 15, indicatorColor: _colors.accent),
  Cat(id: 6, title: '6', assetID: 16, indicatorColor: _colors.shopping),
  Cat(id: 7, title: '7', assetID: 17, indicatorColor: _colors.violet),
  Cat(id: 8, title: '8', assetID: 18, indicatorColor: _colors.green),
  Cat(id: 9, title: '9', assetID: 19, indicatorColor: Color(0xff5ac8fa)),
  Cat(id: 10, title: '10', assetID: 20, indicatorColor: Color(0xffffcc00)),
  Cat(id: 11, title: '11', assetID: 21, indicatorColor: Color(0xff4cd964)),
];

List<Cat> incomeCats = [
  Cat(id: 12, title: '12', assetID: 22, indicatorColor: Color(0xff5856d6)),
  Cat(id: 13, title: '13', assetID: 23, indicatorColor: Color(0xff8e8e93)),
  Cat(id: 14, title: '14', assetID: 24, indicatorColor: Color(0xffff9ff3)),
  Cat(id: 15, title: '15', assetID: 25, indicatorColor: Color(0xff00cec9)),
];

List<Cat> otherCats = [
  Cat(id: 16, title: '16', assetID: 26, indicatorColor: Color(0xfffd79a8)),
];

Cat emptyCat = Cat(
  id: 0,
  title: '',
  assetID: -1,
  colorID: -2,
);
