import 'package:arso_app/functions/localData.dart';
import 'package:flutter/material.dart';

import '../components/weatherDay.dart';
import '../models/weatherDayData.dart';

class WeekTab extends StatefulWidget {
  late List<WeatherDayData> _weekData;
  WeekTab(List<WeatherDayData> weekData, {super.key}) {
    _weekData = weekData;
  }

  @override
  State<WeekTab> createState() => _WeekTabState(_weekData);
}

class _WeekTabState extends State<WeekTab> {
  late List<WeatherDayData> _weekData;
  _WeekTabState(List<WeatherDayData> weekData) {
    _weekData = weekData;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            children: _weekData.map((data) => WeatherDay(data)).toList()));
  }
}
