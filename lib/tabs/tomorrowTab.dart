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
        buildWindAndSunrise(context),
        buildHumidityAndSunset(context),
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
                style: Theme.of(context).textTheme.bodyLarge),
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
            Text(_data.report,
                style: Theme.of(context).textTheme.displayMedium),
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
                          Text(
                            _data.maxTemp,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
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
                      )),
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

  Widget buildWindAndSunrise(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text("Hirost vetra : ",
                    style: Theme.of(context).textTheme.bodyLarge),
                Text(_data.windReport),
                Text(", ${_data.windSpeed} km/h",
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                    image: AssetImage('assets/icons/Arrow_up.png'),
                    width: 10,
                    height: 10,
                    color: Color.fromARGB(131, 255, 255, 255)),
                const Image(
                    image: AssetImage('assets/icons/Sunrise_sunset.png'),
                    width: 20,
                    height: 20,
                    color: Color.fromARGB(131, 255, 255, 255)),
                Text("  ${_data.sunrise}",
                    style: Theme.of(context).textTheme.bodyLarge)
              ],
            )
          ],
        )
      ]),
    );
  }

  Widget buildHumidityAndSunset(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text("Vlažnost : ",
                    style: Theme.of(context).textTheme.bodyLarge),
                Text(_data.humidityReport),
                Text(", ${_data.humidity} %",
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                    image: AssetImage('assets/icons/Arrow_down.png'),
                    width: 10,
                    height: 10,
                    color: Color.fromARGB(131, 255, 255, 255)),
                const Image(
                    image: AssetImage('assets/icons/Sunrise_sunset.png'),
                    width: 20,
                    height: 20,
                    color: Color.fromARGB(131, 255, 255, 255)),
                Text("  ${_data.sunset}",
                    style: Theme.of(context).textTheme.bodyLarge)
              ],
            )
          ],
        )
      ]),
    );
  }
}
