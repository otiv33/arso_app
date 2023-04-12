import 'package:flutter/material.dart';

import '../components/weatherDay.dart';
import '../models/weatherDayData.dart';

class WeekTab extends StatelessWidget {
  late List<WeatherDayData> _weekData;
  WeekTab(List<WeatherDayData> weekData, {super.key}) {
    _weekData = weekData;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            children: _weekData.map((data) => WeatherDay(data)).toList()));
  }
}
