import 'package:flutter/material.dart';
import '../functions/functions.dart';

class CitySearchDelegate extends SearchDelegate<String> {
  List<String> searchResults = [];

  void UpdateCityList(List<String> cityList) {
    searchResults = cityList;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, "");
          } else {
            query = '';
          }
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ""),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text(query));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((el) {
      final result = toLowerAndRemoveSpecial(el);
      final input = toLowerAndRemoveSpecial(query);
      return result.contains(input);
    }).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final city = suggestions[index];
        return ListTile(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 0.3),
          ),
          title: Text(
            city,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          onTap: () {
            query = city;
            close(context, city);
          },
          tileColor: getDefaultColor2(),
        );
      },
    );
  }
}
