import 'package:arso_app/functions/functions.dart';
import 'package:arso_app/models/weatherHourData.dart';
import 'package:arso_app/models/weatherTodayData.dart';
import 'package:intl/intl.dart';

class WeatherTomorrowData extends WeatherTodayData {
  WeatherTomorrowData();

  String report = "";
  String maxTemp = "";
  String minTemp = "";
  String weatherIcon = "";
  String windReport = "";
  String windSpeed = "";
  String humidityReport = "";
  String humidity = "";
  String pressureReport = "";
  String pressure = "";
  String sunrise = "";
  String sunset = "";
  List<WeatherHourData> weatherHourData =
      List<WeatherHourData>.empty(growable: true);

  factory WeatherTomorrowData.fromJson(Map<String, dynamic> json) {
    String nullCheck(obj) {
      return obj ?? "";
    }

    String formatTime(Map arr, String attr) {
      return arr[attr] != null
          ? DateFormat('H:mm').format(DateTime.parse(arr[attr]))
          : "";
    }

    var currentTime =
        json['forecast24h']['features'][0]['properties']['days'][0];
    var current = currentTime['timeline'][0];

    var wTomorrow = WeatherTomorrowData();
    wTomorrow.report = nullCheck(current['clouds_shortText']).capitalize();
    wTomorrow.maxTemp = nullCheck(current['txsyn']);
    wTomorrow.minTemp = nullCheck(current['tnsyn']);
    wTomorrow.weatherIcon = nullCheck(current['clouds_icon_wwsyn_icon']);
    wTomorrow.windReport = nullCheck(current['ff_shortText']);
    wTomorrow.windSpeed = nullCheck(current['ff_val']);
    wTomorrow.humidityReport = nullCheck(current['rh_shortText']);
    wTomorrow.humidity = nullCheck(current['rh']);
    wTomorrow.pressureReport = nullCheck(current['pa_shortText']).capitalize();
    wTomorrow.pressure = nullCheck(current['msl']);
    wTomorrow.sunrise = formatTime(currentTime, 'sunrise');
    wTomorrow.sunset = formatTime(currentTime, 'sunset');
    wTomorrow.weatherHourData = WeatherHourData().listFromJson(json, 1);
    return wTomorrow;
  }
}
