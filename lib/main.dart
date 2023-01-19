import 'package:arso_app/mainTabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
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
            headline1: TextStyle(fontSize: 20.0, color: Colors.white),
            headline2: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            bodyText1: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(131, 255, 255, 255)),
            bodyText2: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
          tabBarTheme: const TabBarTheme(
              labelColor: Colors.white,
              labelStyle: TextStyle(color: Colors.white),
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 2.0, color: Colors.white))),
          scaffoldBackgroundColor: Colors.transparent,
          primarySwatch: Colors.blue),
      home: MainTabs(),
    );
  }
}
