import 'package:arso_app/functions/localData.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_donation_buttons/donationButtons/ko-fiButton.dart';
import 'package:url_launcher/url_launcher.dart';

import '../functions/functions.dart';

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
            buildFavouriteRow(context),
            Expanded(child: Container()),
            buildDonate(context),
            buildInfoRow(context),
          ],
        ));
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

  Widget buildFavouriteRow(BuildContext context) {
    List<Widget> favouriteCities = widget._localDataManager.data.favouriteCities
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
                          widget._localDataManager.removeFromFavourites(city);
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
                        widget._localDataManager.data.cityName = city;
                        widget._localDataManager.updateLocalDataFile();
                        Navigator.pop(context);
                      }),
                ),
              ],
            )))
        .toList();

    // Add empty placeholder
    if (favouriteCities.isEmpty) {
      favouriteCities.add(Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Expanded(
              flex: 10,
              child: ListTile(
                title: Text(
                  "Ni priljubljenih mest ... ",
                  textAlign: TextAlign.center,
                ),
              )),
        ],
      )));
    }

    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: favouriteCities,
    ));
  }

  Widget buildDonate(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30.0))),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => buildDonateDialog(context));
                      },
                      child: const Text(
                        "Zahvali se ☕",
                        textAlign: TextAlign.left,
                      ),
                    )
                  ]),
            ),
          ],
        ));
  }

  Widget buildDonateDialog(BuildContext context) {
    return AlertDialog(
        title: const Text('Zahvali se'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('Neuradna ARSO vremenska aplikacija je nastala z namenom '
              'izboljšati uporabniško izkušnjo dostopa do vremenskih '
              'podatkov. Aplikacija je povsem odprtokodna in prosto '
              'dostopna.\n\n GitHub : '),
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
          )),
          const Text('\nČe ti je aplikacija všeč se lahko zahvališ z majhno '
              'donacijo in kupiš razvijalcem kakšno frutabelo 😊\n'),
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
        ]));
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
