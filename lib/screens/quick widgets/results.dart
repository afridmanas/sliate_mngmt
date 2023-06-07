import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Results extends StatefulWidget {
  const Results({Key? key}) : super(key: key);

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Results',
          style: GoogleFonts.mavenPro(
            textStyle: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: .5),
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
