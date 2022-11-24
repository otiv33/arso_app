import 'dart:convert';
import 'dart:io';

import 'package:arso_app/models/localData.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;

class LocalDataManager {
  String _path = "";

  LocalDataManager() {}

  Future InitialLoad() async {
    var dir = await getApplicationDocumentsDirectory();
    _path = "${dir.path}/assets/data/localData.json";
  }

  Future getLocalDataInitial() async {
    await InitialLoad();
    return await getLocalData();
  }

  Future getLocalData() async {
    if (await File(_path).exists()) {
      String localDataJson = await File(_path).readAsString();
      return LocalData.fromJson(jsonDecode(localDataJson));
    } else {
      await new File(_path).create(recursive: true).then((File file) {
        String sample =
            '{"cityName":"Maribor","defaultCity":"Ljubljana","favouriteCities":[]}';
        file.writeAsString(sample);
        return LocalData.fromJson(jsonDecode(sample));
      });
    }
  }

  Future<void> updateLocalData(LocalData data) async {
    String json = jsonEncode(data.toJson());
    File file = File(_path);
    file.writeAsString(json);
  }
}
