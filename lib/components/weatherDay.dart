import 'package:flutter/material.dart';
import '../models/weatherDayData.dart';

class WeatherDay extends StatefulWidget {
  late WeatherDayData data;

  WeatherDay(WeatherDayData pdata, {super.key}) {
    super.key;
    data = pdata;
  }
  @override
  _WeatherDayState createState() => _WeatherDayState();
}

class _WeatherDayState extends State<WeatherDay> {
  bool showDetails = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              setState(() {
                showDetails = !showDetails;
              }),
            },
        child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.white, width: 0.3),
                    bottom: BorderSide(color: Colors.white, width: 0.3))),
            child: Column(
              children: [
                // Main row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Text(
                            widget.data.day,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              widget.data.date,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ]),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Text(
                            widget.data.report,
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Image(
                                      image: AssetImage(
                                          'assets/icons/${widget.data.weatherIcon}.png'),
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
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 0, 0),
                                        child: Text("${widget.data.maxTemp} °C",
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 0, 0),
                                        child: Text("${widget.data.minTemp} °C",
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                color: Color.fromARGB(
                                                    131, 255, 255, 255),
                                                fontWeight: FontWeight.bold)),
                                      )
                                    ],
                                  ))
                            ],
                          )
                        ]),
                  ],
                ),
                if (showDetails == true) ...[
                  // Weather forecast by time of day
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (widget.data.nightWeatherIcon != "")
                          Column(
                            children: [
                              Text(
                                "Ponoči",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 7, 15, 7),
                                child: Image(
                                  image: AssetImage(
                                      'assets/icons/${widget.data.nightWeatherIcon}.png'),
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              Text(
                                "${widget.data.nightTemp} °C",
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            ],
                          ),
                        if (widget.data.morningWeatherIcon != "")
                          Column(
                            children: [
                              Text(
                                "Zjutraj",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 7, 15, 7),
                                child: Image(
                                  image: AssetImage(
                                      'assets/icons/${widget.data.morningWeatherIcon}.png'),
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              Text(
                                "${widget.data.morningTemp} °C",
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            ],
                          ),
                        if (widget.data.dayWeatherIcon != "")
                          Column(
                            children: [
                              Text(
                                "Čez dan",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 7, 15, 7),
                                child: Image(
                                  image: AssetImage(
                                      'assets/icons/${widget.data.dayWeatherIcon}.png'),
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              Text(
                                "${widget.data.dayTemp} °C",
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            ],
                          ),
                        if (widget.data.eveningWeatherIcon != "")
                          Column(
                            children: [
                              Text(
                                "Zvečer",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 7, 15, 7),
                                child: Image(
                                  image: AssetImage(
                                      'assets/icons/${widget.data.eveningWeatherIcon}.png'),
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              Text(
                                "${widget.data.eveningTemp} °C",
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            ],
                          ),
                      ],
                    ),
                  ),

                  // Details
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Text(
                                  "Tlak : ",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text("${widget.data.pressureDescription}, "),
                                Text(
                                  "${widget.data.pressure} hPa",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Text(
                                  "Vlažnost : ",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text("${widget.data.humidityDescription}, "),
                                Text(
                                  "${widget.data.humidity} % ",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Text(
                                  "Višina oblačnosti : ",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(widget.data.cloudHeight),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Text(
                                    "Veter : ",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    "${widget.data.windDescription}, ",
                                  ),
                                  Text(
                                    "${widget.data.windSpeed} km/h",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Text(
                                    "Sunki do : ",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  if (widget.data.windGustSpeed != "")
                                    Text("${widget.data.windGustSpeed} km/h")
                                  else
                                    const Text("-")
                                ],
                              ),
                            ),
                          ]),
                    ],
                  )
                ]
              ],
            )));
  }
}
