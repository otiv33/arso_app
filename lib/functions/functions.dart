import 'package:intl/intl.dart';

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
    var time = DateTime.parse(arr[attr]);
    if (attr == 'valid') {
      return DateFormat('HH:mm').format(time.add(const Duration(hours: 1)));
    } else {
      return DateFormat('HH:mm').format(time);
    }
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
