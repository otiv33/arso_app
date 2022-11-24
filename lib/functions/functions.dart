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
      int hour = time.hour + 1;
      int minute = time.minute;
      return '$hour:${DateFormat('mm').format(time)}';
    } else {
      return DateFormat('H:mm').format(time);
    }
  } else {
    return "";
  }
}

String getTodayDate() {
  DateTime now = DateTime.now();
  return '${now.day}. ${now.month}. ${now.year}';
}
