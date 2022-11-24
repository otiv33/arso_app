import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../functions/functions.dart';

class WeatherHourData {
  WeatherHourData();
  String hour = "";
  String temperature = "";
  String weatherIcon = "";
  String windIcon = "";
  String windSpeed = "";

  List<WeatherHourData> listFromJson(json) {
    var current =
        json['forecast1h']['features'][0]['properties']['days'][0]['timeline'];

    List<WeatherHourData> listWHour = List.empty(growable: true);
    for (var el in current) {
      var wHour = WeatherHourData();
      wHour.hour = formatDateToTime(el, 'valid');
      wHour.temperature = nullCheck(el['t']);
      wHour.weatherIcon = nullCheck(el['clouds_icon_wwsyn_icon']);
      wHour.windIcon = nullCheck(el['ddff_icon']);
      wHour.windSpeed = nullCheck(el['ff_val']);
      listWHour.add(wHour);
    }
    return listWHour;
  }
}
