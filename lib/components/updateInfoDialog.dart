import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateInfoDialog extends StatefulWidget {
  const UpdateInfoDialog({super.key});

  @override
  State<UpdateInfoDialog> createState() => _UpdateInfoDialogState();
}

class _UpdateInfoDialogState extends State<UpdateInfoDialog> {
  @override
  void initState() {
    super.initState();
    notifyOnNewVersion(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void notifyOnNewVersion(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version.toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? latestAppVersion = pref.getString("latestAppVersion");
    if (currentVersion != latestAppVersion) {
      _showDialog(context);
      pref.setString("latestAppVersion", currentVersion);
    }
  }

  // NEW FEATURES DIALOG
  void _showDialog(BuildContext context) {
    var dialog = AlertDialog(
      title: const Text('New features'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          newFeature('Pogled podrobnosti za napoved po urah'),
          newFeature('Pogled podronnosti za 10 dnevno napoved po dnevih'),
          newFeature('Podatki o sončnem vzhodu in zahodu'),
          newFeature('Home screen widget'),
          newFeature('Dodatne radarske slike'),
          newFeature('Možnost osvežitve ob napaki nalaganja'),
          newFeature('Manjši tehnični in stilski popravki'),
          const Text(
              '\nINFO : Ob kliku na posamezno uro ali dan se sedaj prikaže '
              'več podrobnosti.')
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'))
      ],
    );
    showDialog(context: context, builder: (_) => dialog);
  }

  Widget newFeature(String text) {
    return ListTile(
      minLeadingWidth: 20,
      leading: const Icon(
        Icons.add_circle,
        color: Colors.green,
        size: 20.0,
      ),
      title: Text(text),
    );
  }
}
