import 'package:arso_app/components/radarImageWeb.dart';
import 'package:flutter/material.dart';

import '../weatherImage.dart';

class RadarImageDropdown extends StatefulWidget {
  const RadarImageDropdown({super.key});

  @override
  State<RadarImageDropdown> createState() => RadarImageDropdownState();
}

class RadarImageDropdownState extends State<RadarImageDropdown> {
  Map<String, Icon> iconsMap = {
    'water_drop_outlined':
        const Icon(Icons.water_drop_outlined, color: Colors.white),
    'wb_sunny_outlined':
        const Icon(Icons.wb_sunny_outlined, color: Colors.white),
    'wind_power_rounded':
        const Icon(Icons.wind_power_rounded, color: Colors.white),
    'cloud': const Icon(Icons.cloud, color: Colors.white),
    'water_drop_rounded':
        const Icon(Icons.water_drop_rounded, color: Colors.white),
    'blur_circular_outlined':
        const Icon(Icons.blur_circular_outlined, color: Colors.white),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        decoration: const BoxDecoration(
            color: Color.fromARGB(203, 4, 86, 134),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: IconButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                  ),
                  icon: const Icon(Icons.map),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => WeatherImage(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                  width: 30,
                  child: PopupMenuButton(
                    padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                    offset: const Offset(15, -320),
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    color: const Color.fromARGB(228, 4, 86, 134),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onSelected: (result) {
                      if (result != null) {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (_, __, ___) => RadarImageWeb(result),
                          ),
                        );
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      buildDropDownMenuItem(
                          "Padavine", "tp", "water_drop_outlined"),
                      buildDropDownMenuItem(
                          "Temperature", "t2m", "wb_sunny_outlined"),
                      buildDropDownMenuItem(
                          "Veter", "wind", "wind_power_rounded"),
                      buildDropDownMenuItem("Oblačnost", "sp", "cloud"),
                      buildDropDownMenuItem(
                          "Jakost padavin", "si0zm", "water_drop_rounded"),
                      buildDropDownMenuItem(
                          "Možnost toče", "hp", "blur_circular_outlined"),
                    ],
                  )),
            ]));
  }

  PopupMenuItem buildDropDownMenuItem(
      String text, String action, String iconName) {
    return PopupMenuItem(
      textStyle: const TextStyle(color: Colors.white),
      value: action,
      child: ListTile(
        leading: iconsMap[iconName],
        title: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        dense: true,
      ),
    );
  }
}
