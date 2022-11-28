import 'package:intl/intl.dart';
import 'package:arso_app/functions/functions.dart';

class WeatherDayData {
  WeatherDayData();
  String day = "";
  String date = "";
  String report = "";
  String weatherIcon = "";
  String maxTemp = "";
  String minTemp = "";

  List<WeatherDayData> fromJson(Map<String, dynamic> json) {
    String nullCheck(obj) {
      return obj ?? "";
    }

    String getDayOfWeek(DateTime date) {
      if (DateTime.now().isSameDate(date)) {
        return "Danes";
      }
      if ((DateTime.now().add(const Duration(days: 1))).isSameDate(date)) {
        return "Jutri";
      }

      switch (DateFormat('EEEE').format(date).toLowerCase()) {
        case "monday":
          return "Ponedeljek";
        case "tuesday":
          return "Torek";
        case "wednesday":
          return "Sreda";
        case "thursday":
          return "Četrtek";
        case "friday":
          return "Petek";
        case "saturday":
          return "Sobota";
        case "sunday":
          return "Nedelja";
        default:
          return "";
      }
    }

    List<WeatherDayData> listWday = List.empty(growable: true);

    var current = json['forecast24h']['features'][0]['properties']['days'];
    for (var el in current) {
      var currentEl = el['timeline'][0];
      var wDay = WeatherDayData();

      DateTime date = DateTime.parse(nullCheck(el['date']));
      wDay.day = getDayOfWeek(date);
      wDay.date = DateFormat('dd. MM.').format(date);
      wDay.report = nullCheck(currentEl['clouds_shortText']).capitalize();
      wDay.weatherIcon = nullCheck(currentEl['clouds_icon_wwsyn_icon']);
      wDay.maxTemp = nullCheck(currentEl['txsyn']);
      wDay.minTemp = nullCheck(currentEl['tnsyn']);
      listWday.add(wDay);
    }
    return listWday;
  }
}
