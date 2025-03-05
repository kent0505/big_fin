class Vip {
  Vip({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.previousPrice = 0,
  });

  final int id;
  final String title;
  final String description;
  final double price;
  final double previousPrice;
}

List<Vip> vipsList = [
  Vip(
    id: 1,
    title: 'Weekly Plan',
    description: 'Pay every week',
    price: 20,
  ),
  Vip(
    id: 2,
    title: 'Monthly Plan',
    description: 'Pay every month',
    price: 150,
  ),
  Vip(
    id: 3,
    title: 'Yearly Plan',
    description: 'Pay every year',
    price: 200,
    previousPrice: 399.99,
  ),
];
