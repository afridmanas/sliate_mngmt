import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lectures extends StatefulWidget {
  const Lectures({Key? key}) : super(key: key);

  @override
  _LecturesState createState() => _LecturesState();
}

class _LecturesState extends State<Lectures> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Lecturers',
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
