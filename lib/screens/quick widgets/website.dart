import 'package:flutter/material.dart';
import 'package:sliate/color.dart';
import 'package:webview_flutter/webview_flutter.dart';

class developer extends StatelessWidget {
  const developer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg_clr,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Devloper',
        ),
      ),
      body: const WebView(
        initialUrl: 'https://manasafrid.me/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
