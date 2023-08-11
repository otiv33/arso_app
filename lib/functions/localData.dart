import 'dart:async' show Future;
import 'dart:convert';
import 'dart:io';

import 'package:arso_app/models/localData.dart';
import 'package:path_provider/path_provider.dart';

class LocalDataManager {
  String _path = "";
  LocalData data = LocalData();

  LocalDataManager();

  Future initialLoad() async {
    var dir = await getApplicationDocumentsDirectory();
    _path = "${dir.path}/assets/data/localData.json";
  }

  Future getLocalDataInitial() async {
    await initialLoad();
    data = await getLocalData();
  }

  Future getLocalData() async {
    if (await File(_path).exists()) {
      String localDataJson = await File(_path).readAsString();
      return LocalData.fromJson(jsonDecode(localDataJson));
    } else {
      File file = await File(_path).create(recursive: true);
      String sample =
          '{"cityName":"Maribor","defaultCity":"Maribor","favouriteCities":[]}';
      file.writeAsString(sample);
      return LocalData.fromJson(jsonDecode(sample));
    }
  }

  void updateLocalDataFile() {
    String json = jsonEncode(data.toJson());
    File file = File(_path);
    file.writeAsString(json);
  }

  void addToFavourites(String city) {
    if (!data.favouriteCities.contains(city)) {
      data.favouriteCities.add(city);
      updateLocalDataFile();
    }
  }

  void removeFromFavourites(String city) {
    if (data.favouriteCities.contains(city)) {
      data.favouriteCities.remove(city);
      updateLocalDataFile();
    }
  }

  void selectCity(String city) {
    data.cityName = city;
    updateLocalDataFile();
  }

  void onReorder(int oldIndex, int newIndex) {
    try {
      if (oldIndex < newIndex) newIndex -= 1;

      final String city = data.favouriteCities.removeAt(oldIndex);
      data.favouriteCities.insert(newIndex, city);
      updateLocalDataFile();
    } catch (_) {}
  }
}
