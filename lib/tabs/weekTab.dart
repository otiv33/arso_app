import 'package:flutter/material.dart';

import '../components/weatherDay.dart';

class WeekTab extends StatefulWidget {
  const WeekTab({super.key});

  @override
  State<WeekTab> createState() => _WeekTabState();
}

class _WeekTabState extends State<WeekTab> {
  List<WeatherDayData> _getDayWeatherData() {
    List<WeatherDayData> list = <WeatherDayData>[];
    list.add(WeatherDayData(
        "Danes", "11.11", "Rahlo oblačno", "overcast_RA_day", "13", "12"));
    list.add(WeatherDayData("Ponedeljek", "12.11", "Pretežno oblačno",
        "overcast_RA_day", "-10", "1"));
    list.add(WeatherDayData(
        "Četrtek", "13.11", "Rahlo oblačno", "overcast_RA_day", "0", "-10"));
    return list;
  }

  Column loadHourlyWeather() {
    return Column(
        children:
            _getDayWeatherData().map((data) => WeatherDay(data)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return loadHourlyWeather();
  }
}
