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
  String loadingMessage = "";

  WeatherTodayData _todayData = WeatherTodayData();
  WeatherTomorrowData _tomorrowData = WeatherTomorrowData();
  List<WeatherDayData> _weekData = List.empty(growable: true);

  @override
  void initState() {
    _initLoadingController();
    _initData();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _initLoadingController() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: false);
  }

  void _initData() async {
    await _localDataManager.getLocalDataInitial();
    await _getCityList();
    await _getWeatherData();
  }

  // GET WEATHER
  Future _getWeatherData() async {
    loadingMessage = "Nalaganje ...";
    loaded = false;
    error = false;
    Future.delayed(const Duration(seconds: 3), () {
      if (!loaded)
        context.loaderOverlay.show();
      else
        context.loaderOverlay.hide();
    });

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
      loadingMessage = "Nalaganje je trajalo predolgo";
      error = true;
    } on SocketException catch (_) {
      loadingMessage = "Napaka pri nalaganju";
      error = true;
    } on Exception catch (e) {
      loadingMessage = "Napaka pri nalaganju, " + e.toString();
      error = true;
    }
    if (loaded) {
      context.loaderOverlay.hide();
      updateAppWidget(_localDataManager.data.cityName);
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
        useDefaultLoading: false,
        overlayOpacity: 0.8,
        overlayWidget: buildLoading(),
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
                              _localDataManager.updateLocalDataFile();
                              _getWeatherData();
                            }
                          });
                        },
                        icon: const Icon(Icons.search, color: Colors.white),
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

  Widget buildLoading() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(93, 0, 0, 0),
      // const BoxDecoration(color: ),
      body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            const SizedBox(height: 50),
            Text(loadingMessage,
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 20)),
            const SizedBox(height: 30),
            CircularProgressIndicator(
              value: controller.value,
              color: const Color.fromARGB(255, 255, 255, 255),
              strokeWidth: 5,
            ),
            const SizedBox(height: 30),
            if (error)
              TextButton(
                onPressed: () async => {
                  (context as Element).markNeedsBuild(),
                  Future.delayed(
                      const Duration(milliseconds: 1000),
                      () async => {
                            await _getWeatherData(),
                          }),
                },
                child: SizedBox(
                    width: 100,
                    height: 40,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white, width: 2)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(Icons.refresh, color: Colors.white),
                              Text("  Osveži",
                                  style: TextStyle(color: Colors.white)),
                            ]))),
              )
            // icon: )
          ])),
    );
  }
}
