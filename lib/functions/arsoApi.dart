import 'package:arso_app/models/weatherTodayData.dart';
import 'package:arso_app/models/weatherDayData.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

import '../models/weatherTomorrowData.dart';

class ArsoApi {
  late String _cityName;

  ArsoApi(String cityName) {
    _cityName = cityName;
  }

  Future<Map<String, dynamic>> _getWeatherJson() async {
    Response response = await http
        .get(Uri.parse(
            'https://vreme.arso.gov.si/api/1.0/location/?location=$_cityName'))
        .timeout(const Duration(seconds: 60));
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  // Za spremenit v WEATHER
  Future<Weather> getWeather() async {
    var json = await _getWeatherJson();
    var todayData = WeatherTodayData.fromJson(json);
    var tomorrowData = WeatherTomorrowData.fromJson(json);
    var weekData = WeatherDayData().fromJson(json);
    Weather weather = Weather(todayData, tomorrowData, weekData);
    return weather;
  }
}

class Weather {
  Weather(
      this.weatherCurrentData, this.weatherTomorrowData, this.weatherDayData);

  WeatherTodayData weatherCurrentData;
  WeatherTomorrowData weatherTomorrowData;
  List<WeatherDayData> weatherDayData;
}
