import '../functions/functions.dart';

class WeatherHourData {
  WeatherHourData();
  String hour = "";
  String temperature = "";
  String weatherIcon = "";
  String windIcon = "";
  String windSpeed = "";

  // dayIndex = [0]-today, [1]-tomorrow
  List<WeatherHourData> listFromJson(json, dayIndex) {
    var current = json['forecast1h']['features'][0]['properties']['days']
        [dayIndex]['timeline'];
    var lastHour = null;
    List<WeatherHourData> listWHour = List.empty(growable: true);
    for (var el in current) {
      var wHour = WeatherHourData();
      wHour.hour = formatDateToTime(el, 'valid');
      wHour.temperature = nullCheck(el['t']);
      wHour.weatherIcon = nullCheck(el['clouds_icon_wwsyn_icon']);
      wHour.windIcon = nullCheck(el['ddff_icon']);
      wHour.windSpeed = nullCheck(el['ff_val']);
      listWHour.add(wHour);
      lastHour = DateTime.parse(el['valid']).toLocal();
    }
    if (dayIndex == 1 && lastHour.hour < 23) {
      // Get  3h forecast for tomorrow
      var current = json['forecast3h']['features'][0]['properties']['days']
          [dayIndex]['timeline'];
      for (var el in current) {
        var currentHour = DateTime.parse(el['valid']).toLocal().hour;
        if (currentHour <= lastHour.hour) continue;
        var wHour = WeatherHourData();
        wHour.hour = formatDateToTime(el, 'valid');
        wHour.temperature = nullCheck(el['t']);
        wHour.weatherIcon = nullCheck(el['clouds_icon_wwsyn_icon']);
        wHour.windIcon = nullCheck(el['ddff_icon']);
        wHour.windSpeed = nullCheck(el['ff_val']);
        listWHour.add(wHour);
        lastHour = DateTime.parse(el['valid']).toLocal();
      }
    }
    return listWHour;
  }
}
