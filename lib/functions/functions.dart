import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

String nullCheck(obj) {
  return obj ?? "";
}

String formatDateToTime(Map arr, String attr) {
  if (arr[attr] != null) {
    return DateFormat('HH:mm').format(DateTime.parse(arr[attr]).toLocal());
  } else {
    return "";
  }
}

String getTodayDate() {
  DateTime now = DateTime.now();
  return '${now.day}. ${now.month}. ${now.year}';
}

String getTomorrowDate() {
  DateTime now = DateTime.now().add(const Duration(days: 1));
  return '${now.day}. ${now.month}. ${now.year}';
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

String toLowerAndRemoveSpecial(String data) {
  return data
      .toLowerCase()
      .replaceAll(RegExp(r'š'), 's')
      .replaceAll(RegExp(r'č'), 'c')
      .replaceAll(RegExp(r'ž'), 'z');
}

// For nav bar
Color getDefaultColor1() {
  return const Color.fromARGB(172, 13, 91, 136);
}

// For background
Color getDefaultColor2() {
  return const Color.fromARGB(255, 5, 88, 136);
}
