import 'package:arso_app/mainTabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workmanager/workmanager.dart';

import 'functions/functions.dart';
import 'functions/localData.dart';

const refreshHomeScreenWidget = "refreshHomeScreenWidget";

// MAIN
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Workmanager
  await Workmanager().initialize(
    wmCallbackDispatcher,
    isInDebugMode: true,
  );
  await Workmanager().registerPeriodicTask(
    "1",
    refreshHomeScreenWidget,
    frequency: const Duration(minutes: 15),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
  // Orientation lock
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

void wmCallbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == refreshHomeScreenWidget) {
      var dm = LocalDataManager();
      await dm.getLocalDataInitial();
      updateAppWidget(dm.data.cityName);
    }
    return Future.value(true);
  });
}

// ROOT
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ARSO app',
      theme: ThemeData(
          brightness: Brightness.light,
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 20.0, color: Colors.white),
            displayMedium: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            bodyLarge: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(131, 255, 255, 255)),
            bodyMedium: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
          tabBarTheme: const TabBarTheme(
              labelColor: Colors.white,
              labelStyle: TextStyle(color: Colors.white),
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 2.0, color: Colors.white))),
          scaffoldBackgroundColor: Colors.transparent,
          primarySwatch: Colors.blue),
      home: const MainTabs(),
    );
  }
}
