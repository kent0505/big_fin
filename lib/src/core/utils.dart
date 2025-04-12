import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'config/constants.dart';

int getTimestamp() {
  return DateTime.now().millisecondsSinceEpoch;
}

String timestampToTime(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('HH:mm').format(date);
}

String dateToString(DateTime date) {
  return DateFormat('dd.MM.yyyy').format(date);
}

String timeToString(DateTime time) {
  return DateFormat('HH:mm a').format(time);
}

String getMonthYear(DateTime date, {String locale = Locales.defaultLocale}) {
  return DateFormat('LLLL yyyy', locale).format(date);
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

DateTime monthToDate(String date) {
  try {
    return DateFormat('MMMM yyyy').parse(date);
  } catch (e) {
    logger(e);
    return DateTime.now();
  }
}

String formatDouble(String amount) {
  return double.parse(amount.replaceAll(',', '.')).toStringAsFixed(2);
}

double tryParseDouble(String text) {
  return double.tryParse(text.replaceAll(',', '.')) ?? 0;
}

void logger(Object message) => developer.log(message.toString());

// bool isIOS() => Platform.isIOS;
bool isIOS() => false;

Widget frameBuilder(
  BuildContext context,
  Widget child,
  int? frame,
  bool wasSynchronouslyLoaded,
) {
  return AnimatedOpacity(
    opacity: frame == null ? 0.0 : 1.0,
    duration: const Duration(milliseconds: 1000),
    curve: Curves.easeInOut,
    child: child,
  );
}
