import 'package:flutter/material.dart';
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

  String nightWeatherIcon = "";
  String nightTemp = "";
  String morningWeatherIcon = "";
  String morningTemp = "";
  String dayWeatherIcon = "";
  String dayTemp = "";
  String eveningWeatherIcon = "";
  String eveningTemp = "";

  String windDescription = "";
  String windSpeed = "";
  String windGustSpeed = "";
  String humidityDescription = "";
  String humidity = "";
  String cloudHeight = "";
  String pressureDescription = "";
  String pressure = "";

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

    var current24h = json['forecast24h']['features'][0]['properties']['days'];
    var current6h = json['forecast6h']['features'][0]['properties']['days'];
    int i = 0;
    for (var el in current24h) {
      var currentEl24h = el['timeline'][0];
      var wDay = WeatherDayData();

      DateTime date = DateTime.parse(nullCheck(el['date']));
      wDay.day = getDayOfWeek(date);
      wDay.date = DateFormat('dd. MM.').format(date);
      wDay.report = nullCheck(currentEl24h['clouds_shortText']).capitalize();
      wDay.weatherIcon = nullCheck(currentEl24h['clouds_icon_wwsyn_icon']);
      wDay.maxTemp = nullCheck(currentEl24h['txsyn']);
      wDay.minTemp = nullCheck(currentEl24h['tnsyn']);

      wDay.windDescription = nullCheck(currentEl24h['ff_shortText']);
      wDay.windSpeed = nullCheck(currentEl24h['ff_val']);
      wDay.windGustSpeed = nullCheck(currentEl24h['ffmax_val']);
      wDay.humidityDescription = nullCheck(currentEl24h['rh_shortText']);
      wDay.humidity = nullCheck(currentEl24h['rh']);
      wDay.cloudHeight = nullCheck(currentEl24h['cloudBase_shortText']);
      wDay.pressureDescription = nullCheck(currentEl24h['pa_shortText']);
      wDay.pressure = nullCheck(currentEl24h['msl']);

      try {
        if (current6h[i]['timeline'].length == 4) {
          var night = current6h[i]['timeline'][0];
          wDay.nightWeatherIcon = nullCheck(night['clouds_icon_wwsyn_icon']);
          wDay.nightTemp = nullCheck(night['t']);
          var morning = current6h[i]['timeline'][1];
          wDay.morningWeatherIcon =
              nullCheck(morning['clouds_icon_wwsyn_icon']);
          wDay.morningTemp = nullCheck(morning['t']);
          var day = current6h[i]['timeline'][2];
          wDay.dayWeatherIcon = nullCheck(day['clouds_icon_wwsyn_icon']);
          wDay.dayTemp = nullCheck(day['t']);
          var evening = current6h[i]['timeline'][3];
          wDay.eveningWeatherIcon =
              nullCheck(evening['clouds_icon_wwsyn_icon']);
          wDay.eveningTemp = nullCheck(evening['t']);
        } else {
          // For today date since it doesn't necesarily have 4 elements
          for (var c in current6h[i]['timeline']) {
            var date = DateTime.parse(c['valid']);
            switch (date.hour) {
              case 0:
                wDay.nightWeatherIcon = nullCheck(c['clouds_icon_wwsyn_icon']);
                wDay.nightTemp = nullCheck(c['t']);
                break;
              case 6:
                wDay.morningWeatherIcon =
                    nullCheck(c['clouds_icon_wwsyn_icon']);
                wDay.morningTemp = nullCheck(c['t']);
                break;
              case 12:
                wDay.dayWeatherIcon = nullCheck(c['clouds_icon_wwsyn_icon']);
                wDay.dayTemp = nullCheck(c['t']);
                break;
              case 18:
                wDay.eveningWeatherIcon =
                    nullCheck(c['clouds_icon_wwsyn_icon']);
                wDay.eveningTemp = nullCheck(c['t']);
                break;
              default:
            }
          }
        }
      } catch (e) {
        print(e);
      }

      listWday.add(wDay);
      i++;
    }
    return listWday;
  }
}
