import 'package:flutter/material.dart';
import '../models/weatherHourData.dart';

class WeatherHour extends StatefulWidget {
  late WeatherHourData data;

  WeatherHour(WeatherHourData pdata, {super.key}) {
    super.key;
    data = pdata;
  }
  @override
  _WeatherHourState createState() => _WeatherHourState();
}

class _WeatherHourState extends State<WeatherHour> {
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
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(color: Colors.white, width: 0.3),
                  bottom: BorderSide(color: Colors.white, width: 0.3))),
          child: Column(
            children: [
              // MAIN ROW
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Hour
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          widget.data.hour,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  // Temperature
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text("${widget.data.temperature} °C",
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  // Weather icon
                  Column(children: [
                    Container(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Image(
                            image: AssetImage(
                                'assets/icons/${widget.data.weatherIcon}.png'),
                            width: 50,
                            height: 50))
                  ]),
                  // Wind
                  Column(children: [
                    Row(
                      children: [
                        Image(
                          image: AssetImage(
                              'assets/icons/${widget.data.windIcon}.png'),
                          width: 20,
                          height: 20,
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 15.0,
                          ),
                          child: Container(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Text(widget.data.windSpeed,
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
              ),
              // DETAILS ROW
              if (showDetails == true) ...[
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
                          padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                          child: Row(
                            children: [
                              Text(
                                "Vlažnost : ",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text("${widget.data.humidity} %"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                          child: Row(
                            children: [
                              Text(
                                "Padavine :",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const Image(
                                  image: AssetImage('assets/icons/RA.png'),
                                  width: 20,
                                  height: 20),
                              Text("${widget.data.rainfall} mm"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 5, 10),
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
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  widget.data.windDescription,
                                  textAlign: TextAlign.start,
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
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                if (widget.data.windGustSpeed != "")
                                  Text("${widget.data.windGustSpeed} km/h")
                                else
                                  const Text("/")
                              ],
                            ),
                          ),
                        ]),
                  ],
                )
              ]
            ],
          )),
    );
  }

  List<Widget> mainHourWeather(BuildContext context) {
    return <Widget>[
      // Temperature
      Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text("${widget.data.temperature} °C",
                textAlign: TextAlign.right,
                style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
      // Weather icon
      Column(children: [
        Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Image(
                image:
                    AssetImage('assets/icons/${widget.data.weatherIcon}.png'),
                width: 50,
                height: 50))
      ]),
      // Wind
      Column(children: [
        Row(
          children: [
            Image(
                image: AssetImage('assets/icons/${widget.data.windIcon}.png'),
                width: 20,
                height: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 15.0,
              ),
              child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(widget.data.windSpeed,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                          fontWeight: FontWeight.normal))),
            )
          ],
        )
      ])
    ];
  }
}
