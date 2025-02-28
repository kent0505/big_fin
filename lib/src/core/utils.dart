import 'dart:developer' as developer;
import 'dart:ui';

import 'package:intl/intl.dart';

int getTimestamp() {
  return DateTime.now().millisecondsSinceEpoch;
}

String timestampToString(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('dd.MM.yyyy').format(date);
}

String dateToString(DateTime date) {
  return DateFormat('dd.MM.yyyy').format(date);
}

String timeToString(DateTime time) {
  return DateFormat('HH:mm a').format(time);
}

DateTime stringToDate(String date) {
  try {
    return DateFormat('dd.MM.yyyy').parse(date);
  } catch (e) {
    logger(e);
    return DateTime.now();
  }
}

DateTime timeToDate(String date) {
  try {
    return DateFormat('HH:mm').parse(date.replaceAll(" PM", ""));
  } catch (e) {
    logger(e);
    return DateTime.now();
  }
}

String formatNumber(int number) {
  return NumberFormat('#,###').format(number);
}

void logger(Object message) => developer.log(message.toString());

Color getColor(int id) {
  if (id == 1) return Color(0xffC028BB);
  if (id == 2) return Color(0xffC02846);
  if (id == 3) return Color(0xff9228C0);
  if (id == 4) return Color(0xff4628C0);
  if (id == 5) return Color(0xff289FC0);
  if (id == 6) return Color(0xff28C088);
  if (id == 7) return Color(0xff28C028);
  if (id == 8) return Color(0xffCFD824);
  if (id == 9) return Color(0xffD89924);
  return Color(0xffD86024);
}
