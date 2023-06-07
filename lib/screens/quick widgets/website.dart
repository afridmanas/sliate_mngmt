import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Website extends StatefulWidget {
  const Website({Key? key}) : super(key: key);

  @override
  _WebsiteState createState() => _WebsiteState();
}

class _WebsiteState extends State<Website> {
  final String url = 'http://www.sliate.ac.lk/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Web Site',
          style: GoogleFonts.mavenPro(
            textStyle: const TextStyle(
                fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: .5),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change the color of the back arrow here
        ),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
