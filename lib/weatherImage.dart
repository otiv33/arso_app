import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class WeatherImage extends StatefulWidget {
  String imageUrl =
      "https://meteo.arso.gov.si/uploads/probase/www/observ/radar/si0-rm-anim.gif";

  WeatherImage();

  @override
  _WeatherImageState createState() => _WeatherImageState();
}

class _WeatherImageState extends State<WeatherImage> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(178, 0, 0, 0),
      body: Center(
          child: PhotoView(
        imageProvider: NetworkImage(widget.imageUrl),
        backgroundDecoration: BoxDecoration(color: Colors.transparent),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Color.fromARGB(255, 4, 89, 138),
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
