import '../../../core/config/constants.dart';

class Cat {
  Cat({
    this.id = 0,
    required this.title,
    required this.asset,
    required this.colorID,
  });

  int id;
  String title;
  String asset;
  int colorID;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'asset': asset,
      'colorID': colorID,
    };
  }

  factory Cat.fromMap(Map<String, dynamic> map) {
    return Cat(
      id: map['id'],
      title: map['title'],
      asset: map['asset'],
      colorID: map['colorID'],
    );
  }
}

List<Cat> defaultCats = [
  Cat(title: 'House', asset: Assets.categories1, colorID: 0),
  Cat(title: 'Food', asset: Assets.categories2, colorID: 0),
  Cat(title: 'Transport', asset: Assets.categories3, colorID: 0),
  Cat(title: 'Family', asset: Assets.categories4, colorID: 0),
  Cat(title: 'Health', asset: Assets.categories5, colorID: 0),
  Cat(title: 'Shopping', asset: Assets.categories6, colorID: 0),
  Cat(title: 'Entertainment', asset: Assets.categories7, colorID: 0),
  Cat(title: 'Finance Obligations', asset: Assets.categories8, colorID: 0),
];
