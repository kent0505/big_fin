class Cat {
  Cat({
    required this.id,
    required this.title,
    required this.assetID,
    required this.colorID,
  });

  final int id;
  String title;
  int assetID;
  int colorID;

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
  Cat(id: 1, title: 'House', assetID: 11, colorID: 0),
  Cat(id: 2, title: 'Food', assetID: 12, colorID: 0),
  Cat(id: 3, title: 'Transport', assetID: 13, colorID: 0),
  Cat(id: 4, title: 'Family', assetID: 14, colorID: 0),
  Cat(id: 5, title: 'Health', assetID: 15, colorID: 0),
  Cat(id: 6, title: 'Shopping', assetID: 16, colorID: 0),
  Cat(id: 7, title: 'Entertainment', assetID: 17, colorID: 0),
  Cat(id: 8, title: 'Finance Obligations', assetID: 18, colorID: 0),
];

Cat emptyCat = Cat(
  id: 0,
  title: '',
  assetID: -1,
  colorID: -2,
);
