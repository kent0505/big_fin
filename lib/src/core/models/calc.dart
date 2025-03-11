import '../config/enums.dart';

class Calc {
  Calc({
    required this.devicePower,
    required this.operatingTime,
    required this.tariffAmount,
    required this.operating,
    required this.tariff,
  });

  final double devicePower;
  final double operatingTime;
  final double tariffAmount;
  final Operating operating;
  final Tariff tariff;
}
