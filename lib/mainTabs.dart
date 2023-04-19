import 'dart:convert';
import 'package:arso_app/components/infoDrawer.dart';
import 'package:arso_app/models/weatherDayData.dart';
import 'package:arso_app/models/weatherTodayData.dart';
import 'package:arso_app/models/weatherTomorrowData.dart';
import 'package:arso_app/tabs/todayTab.dart';
import 'package:arso_app/tabs/tomorrowTab.dart';
import 'package:arso_app/tabs/weekTab.dart';
import 'package:arso_app/weatherImage.dart';
import 'package:flutter/material.dart';
import 'components/citySearchDelegate.dart';
import 'functions/arsoApi.dart';
import 'functions/functions.dart';
import 'functions/localData.dart';

class MainTabs extends StatefulWidget {
  const MainTabs({super.key});

  @override
  State<MainTabs> createState() => _MainTabs();
}

class _MainTabs extends State<MainTabs> {
  final CitySearchDelegate _cityListDelegate = CitySearchDelegate();
  final LocalDataManager _localDataManager = LocalDataManager();

  WeatherTodayData _todayData = WeatherTodayData();
  WeatherTomorrowData _tomorrowData = WeatherTomorrowData();
  List<WeatherDayData> _weekData = List.empty(growable: true);

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    await _localDataManager.getLocalDataInitial();
    await _getWeatherData();
    await _getCityList();
    updateAppWidget(_localDataManager.data.cityName);
  }

  // GET WEATHER
  Future _getWeatherData() async {
    Weather weatherData =
        await ArsoApi(_localDataManager.data.cityName).getWeather();
    setState(() {
      _todayData = weatherData.weatherCurrentData;
      _tomorrowData = weatherData.weatherTomorrowData;
      _weekData = weatherData.weatherDayData;
    });
  }

  // GET CITIES
  Future _getCityList() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/data/locations.json");
    var jsonResult = jsonDecode(data);
    _cityListDelegate.updateCityList(List<String>.from(jsonResult));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 3, 105, 163),
              Color.fromARGB(172, 5, 99, 154),
              Color.fromARGB(197, 196, 156, 54),
            ],
          )),
          child: Scaffold(
            appBar: AppBar(
              title: Center(
                  child: Text(
                      textAlign: TextAlign.left,
                      _localDataManager.data.cityName)),
              backgroundColor: getDefaultColor1(),
              actions: [
                IconButton(
                  onPressed: () {
                    var newCity = showSearch(
                        context: context, delegate: _cityListDelegate);
                    // REFRESH WEATHER FOR NEW CITY
                    newCity.then((city) {
                      if (city! != "") {
                        _localDataManager.data.cityName = city;
                        _getWeatherData();
                        _localDataManager.updateLocalDataFile();
                        updateAppWidget(city);
                      }
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'DANES'),
                  Tab(text: 'JUTRI'),
                  Tab(text: '10 DNI')
                ],
              ),
            ),
            drawer: InfoDrawer(_localDataManager),
            onDrawerChanged: (isOpen) {
              if (!isOpen) {
                _getWeatherData();
              }
            },
            body: TabBarView(children: [
              TodayTab(_todayData, _localDataManager),
              TomorrowTab(_tomorrowData, _localDataManager),
              WeekTab(_weekData)
            ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (_, __, ___) => WeatherImage(),
                  ),
                );
              },
              backgroundColor: const Color.fromARGB(177, 4, 89, 138),
              child: const Icon(Icons.map),
            ),
          ),
        ));
  }
}
