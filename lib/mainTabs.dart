import 'dart:convert';
import 'dart:io';
import 'package:arso_app/models/weatherTodayData.dart';
import 'package:arso_app/models/weatherTomorrowData.dart';
import 'package:arso_app/tabs/todayTab.dart';
import 'package:arso_app/tabs/tomorrowTab.dart';
import 'package:arso_app/tabs/weekTab.dart';
import 'package:flutter/material.dart';
import 'components/citySearchDelegate.dart';
import 'functions/arsoApi.dart';
import 'models/localData.dart';
import 'package:path_provider/path_provider.dart';
import 'functions/localData.dart';

class MainTabs extends StatefulWidget {
  const MainTabs({super.key});

  @override
  State<MainTabs> createState() => _MainTabs();
}

class _MainTabs extends State<MainTabs> {
  CitySearchDelegate _cityListDelegate = CitySearchDelegate();
  LocalDataManager _localDataManager = LocalDataManager();
  LocalData _localData = LocalData();

  WeatherTodayData _todayData = WeatherTodayData();
  WeatherTomorrowData _tomorrowData = WeatherTomorrowData();

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    _localData = await _localDataManager.getLocalDataInitial();
    await _getWeatherData();
    await _getCityList();
  }

  // GET WEATHER
  Future _getWeatherData() async {
    WeatherTodayData data = await ArsoApi(_localData.cityName).getWeather();
    setState(() {
      _todayData = data;
    });
  }

  // GET CITIES
  Future _getCityList() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/data/locations.json");
    var jsonResult = jsonDecode(data);
    _cityListDelegate.UpdateCityList(List<String>.from(jsonResult));
  }

  void hamburgerOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: hamburgerOnPressed, icon: const Icon(Icons.menu)),
          title: Center(
              child: Text(textAlign: TextAlign.center, _localData.cityName)),
          backgroundColor: const Color.fromARGB(255, 0, 130, 188),
          actions: [
            IconButton(
              onPressed: () {
                var newCity =
                    showSearch(context: context, delegate: _cityListDelegate);
                // REFRESH WEATHER FOR NEW CITY
                newCity.then((value) {
                  if (value! != "") {
                    _localData.cityName = value;
                    _getWeatherData();
                    _localDataManager.updateLocalData(_localData);
                  }
                });
              },
              icon: const Icon(Icons.search),
            ),
          ],
          bottom: const TabBar(
            tabs: [Tab(text: 'DANES'), Tab(text: 'JUTRI'), Tab(text: '10 DNI')],
          ),
        ),
        body: TabBarView(children: [
          TodayTab(_todayData),
          const TomorrowTab(),
          const WeekTab()
        ]),
      ),
    );
  }
}
