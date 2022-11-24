import 'package:arso_app/models/weatherTodayData.dart';
import 'package:arso_app/models/weatherDayData.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

import '../models/weatherHourData.dart';

class ArsoApi {
  late String _cityName;

  ArsoApi(String cityName) {
    _cityName = cityName;
  }

  Future<Map<String, dynamic>> _getWeatherJson() async {
    Response response = await http.get(Uri.parse(
        'https://vreme.arso.gov.si/api/1.0/location/?location=$_cityName'));
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  // Za spremenit v WEATHER
  Future<WeatherTodayData> getWeather() async {
    var json = await _getWeatherJson();
    var todayData = WeatherTodayData.fromJson(json);
    return todayData;
  }
}

class Weather {
  Weather(this.weatherCurrentData, this.weatherDayData, this.weatherHourData);

  WeatherTodayData weatherCurrentData;
  WeatherHourData weatherHourData;
  WeatherDayData weatherDayData;
}
