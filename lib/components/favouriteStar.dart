import 'package:arso_app/functions/localData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FavouriteStar extends StatefulWidget {
  late LocalDataManager _localDataManager;
  FavouriteStar(LocalDataManager localDataManager, {super.key}) {
    _localDataManager = localDataManager;
  }

  @override
  State<FavouriteStar> createState() => _FavouriteStarState(_localDataManager);
}

class _FavouriteStarState extends State<FavouriteStar> {
  late LocalDataManager _localDataManager;
  _FavouriteStarState(LocalDataManager localDataManager) {
    _localDataManager = localDataManager;
  }

  @override
  Widget build(BuildContext context) {
    if (_localDataManager.data.favouriteCities
        .contains(_localDataManager.data.cityName)) {
      return IconButton(
          icon: const Icon(
            Icons.star,
            color: Color.fromARGB(255, 255, 255, 0),
          ),
          onPressed: () {
            setState(() {
              _localDataManager
                  .removeFromFavourites(_localDataManager.data.cityName);
            });
          });
    } else {
      return IconButton(
          icon: const Icon(Icons.star_border_outlined,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            setState(() {
              _localDataManager
                  .addToFavourites(_localDataManager.data.cityName);
            });
          });
    }
  }
}
