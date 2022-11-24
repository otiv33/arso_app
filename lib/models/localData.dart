class LocalData {
  LocalData();

  String cityName = "";
  String defaultCity = "";
  List<String> favouriteCities = [];

  factory LocalData.fromJson(Map<String, dynamic> json) {
    var data = LocalData();
    data.cityName = json['cityName'];
    data.defaultCity = json['defaultCity'];
    if (data.cityName == "") {
      data.cityName = data.defaultCity;
    }
    data.favouriteCities = List<String>.from(json['favouriteCities']);
    return data;
  }

  Map toJson() => {
        'cityName': cityName,
        'defaultCity': defaultCity,
        'favouriteCities': favouriteCities
      };
}
