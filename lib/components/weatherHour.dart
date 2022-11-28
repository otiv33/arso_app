import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/weatherHourData.dart';

class WeatherHour extends StatelessWidget {
  late WeatherHourData _data;
  WeatherHour(WeatherHourData data, {super.key}) {
    super.key;
    _data = data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.white, width: 0.3),
                bottom: BorderSide(color: Colors.white, width: 0.3))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    _data.hour,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text("${_data.temperature} °C",
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
            Column(children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SvgPicture.asset('assets/icons/${_data.weatherIcon}.svg',
                    width: 50, height: 50, semanticsLabel: 'overcast_RA_day'),
              )
            ]),
            Column(children: [
              Row(
                children: [
                  SvgPicture.asset('assets/icons/${_data.windIcon}.svg',
                      color: Colors.white,
                      width: 20,
                      height: 20,
                      semanticsLabel: 'heavyNE'),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 15.0,
                    ),
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Text(_data.windSpeed,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                                fontWeight: FontWeight.normal))),
                  )
                ],
              )
            ]),
          ],
        ));
  }
}
