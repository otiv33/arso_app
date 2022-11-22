import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../components/weatherHour.dart';

class TodayTab extends StatefulWidget {
  const TodayTab({super.key});

  @override
  State<TodayTab> createState() => _TodayTabState();
}

class _TodayTabState extends State<TodayTab> {
  String _getDate() {
    DateTime now = DateTime.now();
    return '${now.day}. ${now.month}. ${now.year}';
  }

  WeatherCurrentData _getcurrentWeatherData() {
    var data = WeatherCurrentData("Pretežno oblačno", "-13", "overcast_RA_day",
        "šibek S", "3", "visoka", "100");
    return data;
  }

  List<WeatherHourData> _gethourWeatherData() {
    List<WeatherHourData> list = <WeatherHourData>[];
    list.add(
        WeatherHourData("12:00", "14", "overcast_RA_day", "heavyNE", "13"));
    list.add(
        WeatherHourData("13:00", "-10", "overcast_RA_day", "heavyNE", "20"));
    list.add(WeatherHourData("14:00", "3", "overcast_RA_day", "heavyNE", "4"));
    return list;
  }

  Column loadHourlyWeather() {
    return Column(
        children:
            _gethourWeatherData().map((data) => WeatherHour(data)).toList());
  }

  @override
  Widget build(BuildContext context) {
    WeatherCurrentData current = _getcurrentWeatherData();

    return Scaffold(
        body: Container(
      child: Column(children: [
        // DATUM
        Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
            child: Row(
              children: [
                Text(_getDate(), style: Theme.of(context).textTheme.bodyText1),
              ],
            )),
        // TRENUTNO VREME BESEDA
        Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
            child: Row(
              children: [
                Text(current.report,
                    style: Theme.of(context).textTheme.headline2),
              ],
            )),
        // TEMPERATURA + ICON
        Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 108.0,
                    ),
                    child: Text(
                      current.temp,
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 30, 40),
                    child: const Text(
                      "°C",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(131, 255, 255, 255)),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: SvgPicture.asset(
                          'assets/icons/${current.weatherIcon}.svg',
                          width: 110,
                          height: 110,
                          semanticsLabel: 'overcast_RA_day'))
                ],
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Hirost vetra : ",
                    style: Theme.of(context).textTheme.bodyText1),
                Text(current.windReport),
                Text(", ${current.windSpeed} km/h",
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            )
          ]),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Vlažnost : ",
                    style: Theme.of(context).textTheme.bodyText1),
                Text(current.humidityReport),
                Text(", ${current.humidity} %",
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            )
          ]),
        ),
        // VREME PO URAH
        loadHourlyWeather()
      ]),
    ));
  }
}

class WeatherCurrentData {
  WeatherCurrentData(this.report, this.temp, this.weatherIcon, this.windReport,
      this.windSpeed, this.humidityReport, this.humidity);
  String report = "";
  String temp = "";
  String weatherIcon = "";
  String windReport = "";
  String windSpeed = "";
  String humidityReport = "";
  String humidity = "";
}
