import 'package:arso_app/models/weatherTomorrowData.dart';
import 'package:flutter/material.dart';
import '../components/favouriteStar.dart';
import '../functions/functions.dart';
import '../functions/localData.dart';

class TomorrowTab extends StatelessWidget {
  late WeatherTomorrowData _data;
  late LocalDataManager _localDataManager;
  TomorrowTab(
      WeatherTomorrowData tomorrowData, LocalDataManager localDataManager,
      {super.key}) {
    _data = tomorrowData;
    _localDataManager = localDataManager;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        buildTodayDate(context),
        buildWeatherReport(context),
        buildTempWithIcon(context),
        buildWind(context),
        buildHumidity(context),
        // VREME PO URAH
        _data.buildHouryWeatherRows()
      ]),
    ));
  }

  Widget buildTodayDate(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 5, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(getTomorrowDate(),
                style: Theme.of(context).textTheme.bodyText1),
            FavouriteStar(_localDataManager),
          ],
        ));
    // return ;
  }

  Widget buildWeatherReport(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
        child: Row(
          children: [
            Text(_data.report, style: Theme.of(context).textTheme.headline2),
          ],
        ));
  }

  Widget buildTempWithIcon(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 108.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Text(
                              _data.maxTemp,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                              top: BorderSide(
                                color: Color.fromARGB(164, 255, 255, 255),
                                width: 1,
                              ),
                            )),
                            child: Text(
                              _data.minTemp,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  color: Color.fromARGB(164, 255, 255, 255),
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                      // child: Text(
                      //   _data.temp,
                      //   textAlign: TextAlign.right,
                      //   style:
                      //       TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                      // ),
                      ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: const Text(
                      "°C",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(131, 255, 255, 255)),
                    ),
                  )
                ],
              )
            ],
          ),
          Column(
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                  child: Image(
                      image:
                          AssetImage('assets/icons/${_data.weatherIcon}.png'),
                      width: 110,
                      height: 110))
            ],
          )
        ],
      ),
    );
  }

  Widget buildWind(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Hirost vetra : ",
                style: Theme.of(context).textTheme.bodyText1),
            Text(_data.windReport),
            Text(", ${_data.windSpeed} km/h",
                style: Theme.of(context).textTheme.bodyText1),
          ],
        )
      ]),
    );
  }

  Widget buildHumidity(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Vlažnost : ", style: Theme.of(context).textTheme.bodyText1),
            Text(_data.humidityReport),
            Text(", ${_data.humidity} %",
                style: Theme.of(context).textTheme.bodyText1),
          ],
        )
      ]),
    );
  }
}
