class CalcResult {
  CalcResult({
    required this.id,
    required this.energy,
    required this.cost,
    required this.currency,
  });

  final int id;
  final String energy;
  final String cost;
  final String currency;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'energy': energy,
      'cost': cost,
      'currency': currency,
    };
  }

  factory CalcResult.fromMap(Map<String, dynamic> map) {
    return CalcResult(
      id: map['id'],
      energy: map['energy'],
      cost: map['cost'],
      currency: map['currency'],
    );
  }
}
