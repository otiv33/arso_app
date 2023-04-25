import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:arso_app/components/infoDrawer.dart';
import 'package:arso_app/components/radarImageDropdown.dart';
import 'package:arso_app/models/weatherDayData.dart';
import 'package:arso_app/models/weatherTodayData.dart';
import 'package:arso_app/models/weatherTomorrowData.dart';
import 'package:arso_app/tabs/todayTab.dart';
import 'package:arso_app/tabs/tomorrowTab.dart';
import 'package:arso_app/tabs/weekTab.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'components/citySearchDelegate.dart';
import 'functions/arsoApi.dart';
import 'functions/functions.dart';
import 'functions/localData.dart';

class MainTabs extends StatefulWidget {
  const MainTabs({super.key});

  @override
  State<MainTabs> createState() => _MainTabs();
}

class _MainTabs extends State<MainTabs> with TickerProviderStateMixin {
  late AnimationController controller;
  final CitySearchDelegate _cityListDelegate = CitySearchDelegate();
  final LocalDataManager _localDataManager = LocalDataManager();
  bool loaded = false;
  bool error = false;
  String loadingMessage = "Nalaganje ...";

  WeatherTodayData _todayData = WeatherTodayData();
  WeatherTomorrowData _tomorrowData = WeatherTomorrowData();
  List<WeatherDayData> _weekData = List.empty(growable: true);

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: false);
    _initData();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _initData() async {
    await _localDataManager.getLocalDataInitial();
    await _getWeatherData();
    await _getCityList();
    updateAppWidget(_localDataManager.data.cityName);
    if (!loaded) {
      context.loaderOverlay.show();
    }
  }

  // GET WEATHER
  Future _getWeatherData() async {
    try {
      Weather weatherData =
          await ArsoApi(_localDataManager.data.cityName).getWeather();
      setState(() {
        _todayData = weatherData.weatherCurrentData;
        _tomorrowData = weatherData.weatherTomorrowData;
        _weekData = weatherData.weatherDayData;
      });
      loaded = true;
    } on TimeoutException catch (_) {
      loadingMessage = "Timeout exception";
      error = true;
    } on SocketException catch (_) {
      loadingMessage = "Socket exception";
      error = true;
    }
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
    return LoaderOverlay(
        useDefaultLoading: true,
        overlayOpacity: 0.8,
        overlayWidget: Center(
          child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 225, 5, 5)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const SizedBox(height: 50),
                    Text(loadingMessage,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20)),
                    // const SizedBox(height: 30),
                    CircularProgressIndicator(
                      value: controller.value,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      strokeWidth: 5,
                    ),
                    // const SizedBox(height: 30),
                    if (error)
                      TextButton(
                        // color: Color.fromARGB(255, 255, 255, 255),
                        onPressed: () async => {
                          print("ALOS"),
                          (context as Element).markNeedsBuild(),
                          // loaded = false,
                          // error = false,
                          // loadingMessage = "Nalaganje ...",
                          // await _getWeatherData(),
                          // await _getCityList(),
                          // updateAppWidget(_localDataManager.data.cityName)
                        },
                        child: Text("Osveži"),
                      )
                    // icon: const Icon(Icons.refresh))
                  ])),
        ),
        child: DefaultTabController(
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
                  floatingActionButton: const RadarImageDropdown()),
            )));
  }
}
