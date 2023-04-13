import 'package:flutter/material.dart';
import '../models/weatherDayData.dart';

class WeatherDay extends StatelessWidget {
  late WeatherDayData _data;

  WeatherDay(WeatherDayData data, {super.key}) {
    _data = data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.white, width: 0.3),
                bottom: BorderSide(color: Colors.white, width: 0.3))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _data.day,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          _data.date,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ]),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Text(
                    _data.report,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Image(
                              image: AssetImage(
                                  'assets/icons/${_data.weatherIcon}.png'),
                              width: 50,
                              height: 50)),
                      ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 67.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: Text("${_data.maxTemp} °C",
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: Text("${_data.minTemp} °C",
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        color:
                                            Color.fromARGB(131, 255, 255, 255),
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ))
                    ],
                  )
                ]),
          ],
        ));
  }
}
