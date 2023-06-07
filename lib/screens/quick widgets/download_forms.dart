import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DownloadForms extends StatefulWidget {
  const DownloadForms({Key? key}) : super(key: key);

  @override
  _DownloadFormsState createState() => _DownloadFormsState();
}

class _DownloadFormsState extends State<DownloadForms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Download Collections',
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
    );
  }
}
