enum PickerMode { date, time, monthYear }

enum Period { monthly, weekly, daily }

enum Operating { minutes, hours, days }

enum Tariff { usd, gbp, eur, rub }

String getTariffText(Tariff tariff) {
  if (tariff == Tariff.usd) return 'USD';
  if (tariff == Tariff.eur) return 'EUR';
  if (tariff == Tariff.gbp) return 'GBP';
  return 'RUB';
}

String getTariffSign(Tariff tariff) {
  if (tariff == Tariff.usd) return '\$';
  if (tariff == Tariff.eur) return '€';
  if (tariff == Tariff.gbp) return '£';
  return '₽';
}
