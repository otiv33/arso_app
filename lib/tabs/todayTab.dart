import 'package:arso_app/components/favouriteStar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../functions/functions.dart';
import '../models/weatherTodayData.dart';
import 'package:arso_app/functions/localData.dart';

class TodayTab extends StatelessWidget {
  late WeatherTodayData _data;
  late LocalDataManager _localDataManager;
  TodayTab(WeatherTodayData data, LocalDataManager localDataManager,
      {super.key}) {
    _data = data;
    _localDataManager = localDataManager;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        buildTodayDateWithFavourite(context),
        buildWeatherReport(context),
        buildTempWithIcon(context),
        buildWind(context),
        buildHumidity(context),
        // VREME PO URAH
        _data.buildHouryWeatherRows()
      ]),
    ));
  }

  Widget buildTodayDateWithFavourite(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(getTodayDate(), style: Theme.of(context).textTheme.bodyText1),
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
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 108.0,
                    ),
                    child: Text(
                      _data.temp,
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: const Text(
                      "??C",
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
                  child: SvgPicture.asset(
                      'assets/icons/${_data.weatherIcon}.svg',
                      width: 110,
                      height: 110,
                      semanticsLabel: 'overcast_RA_day'))
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
            Text("Vla??nost : ", style: Theme.of(context).textTheme.bodyText1),
            Text(_data.humidityReport),
            Text(", ${_data.humidity} %",
                style: Theme.of(context).textTheme.bodyText1),
          ],
        )
      ]),
    );
  }
}
