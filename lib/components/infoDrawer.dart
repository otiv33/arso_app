import 'package:arso_app/functions/localData.dart';
import 'package:flutter/material.dart';

class InfoDrawer extends StatefulWidget {
  late LocalDataManager _localDataManager;
  InfoDrawer(LocalDataManager localDataManager, {super.key}) {
    _localDataManager = localDataManager;
  }

  @override
  State<InfoDrawer> createState() => _InfoDrawerState(_localDataManager);
}

class _InfoDrawerState extends State<InfoDrawer> {
  late LocalDataManager _localDataManager;
  _InfoDrawerState(LocalDataManager localDataManager) {
    _localDataManager = localDataManager;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color.fromARGB(255, 0, 130, 188),
        child: Column(
          children: [
            buildHeader(context),
            buildFavouriteRow(context),
            Expanded(child: Container()),
            buildInfoRow(context)
          ],
        ));
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
      child: const Text(
        "Seznam priljubljenih",
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
      ),
    );
  }

  Widget buildFavouriteRow(BuildContext context) {
    List<Widget> favouriteCities = _localDataManager.data.favouriteCities
        .map((city) => Container(
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.white, width: 0.3),
                    bottom: BorderSide(color: Colors.white, width: 0.3))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          _localDataManager.removeFromFavourites(city);
                        });
                      },
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.white,
                      )),
                ),
                Expanded(
                  flex: 9,
                  child: ListTile(
                      title: Text(
                        city,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      onTap: () {
                        _localDataManager.data.cityName = city;
                        _localDataManager.updateLocalDataFile();
                        Navigator.pop(context);
                      }),
                ),
              ],
            )))
        .toList();

    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: favouriteCities,
    ));
  }

  Widget buildInfoRow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Text(
        "Vir podatkov : Agencija Republike Slovenje za okolje",
      ),
    );
  }
}
