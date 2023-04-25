import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RadarImageWeb extends StatefulWidget {
  String url = 'https://meteo.arso.gov.si/uploads/meteo/app/inca/m/?par=';

  RadarImageWeb(String action, {super.key}) {
    url = url + action;
  }
  @override
  State<RadarImageWeb> createState() => RadarImageWebState();
}

class RadarImageWebState extends State<RadarImageWeb> {
  late final WebViewController webController;
  var loadingPercentage = 0;
  late final AnimationController loadingController;
  var progress = 0.0;
  var progressText = "0 %";

  @override
  void initState() {
    super.initState();
    webController = getWebViewController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(178, 0, 0, 0),
        body: Stack(children: [
          if (progress < 1)
            Center(
                child: CircularPercentIndicator(
              radius: 45.0,
              lineWidth: 4.0,
              percent: progress,
              center: Text(progressText),
              progressColor: const Color.fromARGB(255, 10, 111, 194),
            )),
          Center(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 100),
                  child: WebViewWidget(controller: webController)))
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: const Color.fromARGB(255, 4, 89, 138),
          child: const Icon(Icons.arrow_back),
        ));
  }

  WebViewController getWebViewController() {
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color.fromARGB(0, 0, 0, 0))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progressInt) {
            setState(() {
              progress = progressInt / 100;
              progressText = "$progressInt %";
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {
            setState(() {
              progress = 0;
              progressText = error.description;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            if (!request.url.startsWith('https://meteo.arso.gov.si')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }
}
