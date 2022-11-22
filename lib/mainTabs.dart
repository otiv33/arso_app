import 'package:arso_app/tabs/todayTab.dart';
import 'package:arso_app/tabs/tomorrowTab.dart';
import 'package:arso_app/tabs/weekTab.dart';
import 'package:flutter/material.dart';

class MainTabs extends StatefulWidget {
  const MainTabs({super.key});

  @override
  State<MainTabs> createState() => _MainTabs();
}

class _MainTabs extends State<MainTabs> {
  String _cityName = 'Maribor';

  List<Tab> tabs = <Tab>[
    Tab(text: 'DANES'),
    Tab(text: 'JUTRI'),
    Tab(text: '10 DNI'),
  ];

  void hamburgerOnPressed() {}
  void searchOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: hamburgerOnPressed, icon: const Icon(Icons.menu)),
          title: Center(child: Text(textAlign: TextAlign.center, _cityName)),
          backgroundColor: Color.fromARGB(255, 0, 130, 188),
          actions: [
            IconButton(
              onPressed: searchOnPressed,
              icon: const Icon(Icons.search),
            ),
          ],
          bottom: TabBar(
            tabs: tabs,
          ),
        ),
        body:
            const TabBarView(children: [TodayTab(), TomorrowTab(), WeekTab()]),
      ),
    );
  }
}
