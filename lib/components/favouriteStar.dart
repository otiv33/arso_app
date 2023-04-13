import 'package:arso_app/functions/localData.dart';
import 'package:flutter/material.dart';

class FavouriteStar extends StatefulWidget {
  late LocalDataManager _localDataManager;
  FavouriteStar(LocalDataManager localDataManager, {super.key}) {
    _localDataManager = localDataManager;
  }

  @override
  State<FavouriteStar> createState() => _FavouriteStarState();
}

class _FavouriteStarState extends State<FavouriteStar> {
  @override
  Widget build(BuildContext context) {
    if (widget._localDataManager.data.favouriteCities
        .contains(widget._localDataManager.data.cityName)) {
      return IconButton(
          icon: const Icon(
            Icons.star,
            color: Color.fromARGB(255, 255, 255, 0),
          ),
          onPressed: () {
            setState(() {
              widget._localDataManager
                  .removeFromFavourites(widget._localDataManager.data.cityName);
            });
          });
    } else {
      return IconButton(
          icon: const Icon(Icons.star_border_outlined,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            setState(() {
              widget._localDataManager
                  .addToFavourites(widget._localDataManager.data.cityName);
            });
          });
    }
  }
}
