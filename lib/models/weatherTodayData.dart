import 'package:arso_app/models/weatherHourData.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:arso_app/functions/functions.dart';

import '../components/weatherHour.dart';

class WeatherTodayData {
  String report = "";
  String temp = "";
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

  WeatherTodayData();

  factory WeatherTodayData.fromJson(Map<String, dynamic> json) {
    String nullCheck(obj) {
      return obj ?? "";
    }

    String formatTime(Map arr, String attr) {
      return arr[attr] != null
          ? DateFormat('H:mm').format(DateTime.parse(arr[attr]))
          : "";
    }

    var currentTime =
        json['observation']['features'][0]['properties']['days'][0];
    var current = currentTime['timeline'][0];

    var wToday = WeatherTodayData();
    wToday.report = nullCheck(current['clouds_shortText']).capitalize();
    wToday.temp = nullCheck(current['t']);
    wToday.weatherIcon = nullCheck(current['clouds_icon_wwsyn_icon']);
    wToday.windReport = nullCheck(current['ff_shortText']);
    wToday.windSpeed = nullCheck(current['ff_val']);
    wToday.humidityReport = nullCheck(current['rh_shortText']);
    wToday.humidity = nullCheck(current['rh']);
    wToday.pressureReport = nullCheck(current['pa_shortText']).capitalize();
    wToday.pressure = nullCheck(current['msl']);
    wToday.sunrise = formatTime(currentTime, 'sunrise');
    wToday.sunset = formatTime(currentTime, 'sunset');
    wToday.weatherHourData = WeatherHourData().listFromJson(json, 0);
    return wToday;
  }

  Column buildHouryWeatherRows() {
    return Column(
        children:
            this.weatherHourData.map((data) => WeatherHour(data)).toList());
  }
}
