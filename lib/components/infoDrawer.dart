import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_donation_buttons/donationButtons/ko-fiButton.dart';
import 'package:url_launcher/url_launcher.dart';

import '../functions/functions.dart';
import "../functions/localData.dart";

class InfoDrawer extends StatefulWidget {
  late LocalDataManager _localDataManager;
  InfoDrawer(LocalDataManager localDataManager, {super.key}) {
    _localDataManager = localDataManager;
  }

  @override
  State<InfoDrawer> createState() => _InfoDrawerState();
}

class _InfoDrawerState extends State<InfoDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: getDefaultColor2(),
      child: Column(
        children: [
          buildFavouriteHeader(context),
          Expanded(
            child: ReorderableFavoritesList(
              localDataManager: widget._localDataManager,
            ),
          ),
          const DonateButton(),
          buildInfoRow(context),
        ],
      ),
    );
  }

  Widget buildFavouriteHeader(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Container(
      padding: EdgeInsets.fromLTRB(10, statusBarHeight + 10, 10, 10),
      child: const Text(
        "Seznam priljubljenih",
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
      ),
    );
  }

  Widget buildInfoRow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: const Text(
        "Vir podatkov : Agencija Republike Slovenje Za Okolje",
      ),
    );
  }
}

class ReorderableFavoritesList extends StatelessWidget {
  final LocalDataManager localDataManager;
  const ReorderableFavoritesList({super.key, required this.localDataManager});

  @override
  Widget build(BuildContext context) {
    final List<String> favouriteCities = localDataManager.data.favouriteCities;

    // Add empty placeholder
    if (favouriteCities.isEmpty) {
      return const Center(
        child: ListTile(
          title: Text(
            "Ni priljubljenih mest ... \n Nova mesta lahko dodate s klikom na zvezdico",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: ReorderableListView.builder(
        onReorder: localDataManager.onReorder,
        itemBuilder: (BuildContext context, int index) {
          final String city = favouriteCities[index];
          return FavoriteCityTile(
            key: ValueKey(city),
            city: city,
            onRemove: () => localDataManager.removeFromFavourites(city),
            onTap: () {
              localDataManager.selectCity(city);
              Navigator.pop(context);
            },
          );
        },
        itemCount: favouriteCities.length,
      ),
    );
  }
}

class FavoriteCityTile extends StatelessWidget {
  final String city;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const FavoriteCityTile({
    required super.key,
    required this.city,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      key: key,
      child: ListTile(
        contentPadding: const EdgeInsetsDirectional.only(start: 5, end: 20),
        shape: const Border(
          top: BorderSide(color: Colors.white, width: 0.3),
          bottom: BorderSide(color: Colors.white, width: 0.3),
        ),
        title: Text(
          city,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: onRemove,
          icon: const Icon(
            Icons.remove_circle_outline,
            color: Colors.white,
          ),
        ),
        trailing: const Icon(
          Icons.drag_handle,
          color: Colors.white,
        ),
        onTap: onTap,
      ),
    );
  }
}

class DonateButton extends StatelessWidget {
  const DonateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const DonateDialog(),
                );
              },
              child: const Text("Zahvali se ☕", textAlign: TextAlign.left),
            )
          ],
        ),
      ),
    );
  }
}

class DonateDialog extends StatelessWidget {
  const DonateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Zahvali se'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Neuradna ARSO vremenska aplikacija je nastala z namenom '
            'izboljšati uporabniško izkušnjo dostopa do vremenskih '
            'podatkov. Aplikacija je povsem odprtokodna in prosto '
            'dostopna.\n\n GitHub : ',
          ),
          RichText(
            text: TextSpan(
              text: 'https://github.com/otiv33/arso_app',
              style: const TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  var url = Uri.parse('https://github.com/otiv33/arso_app');
                  if (!await launchUrl(url)) {
                    throw 'Could not launch $url';
                  }
                },
            ),
          ),
          const Text(
            '\nČe ti je aplikacija všeč se lahko zahvališ z majhno '
            'donacijo in kupiš razvijalcu kakšno frutabelo 😊\n',
          ),
          KofiButton(
            kofiName: "Vito Abeln",
            kofiColor: KofiColor.Red,
            onDonation: () async {
              var url = Uri.parse('https://ko-fi.com/vitoabeln');
              if (!await launchUrl(url)) {
                throw 'Could not launch $url';
              }
            },
          ),
        ],
      ),
    );
  }
}
