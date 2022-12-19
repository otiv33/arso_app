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
      backgroundColor: Color.fromARGB(178, 0, 0, 0),
      // appBar: AppBar(
      //   title: const Text('FloatingActionButton Sample'),
      // ),
      body: Center(
          child: PhotoView(
        imageProvider: NetworkImage(widget.imageUrl),
        backgroundDecoration: BoxDecoration(color: Colors.transparent),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Color.fromARGB(182, 82, 146, 255),
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
