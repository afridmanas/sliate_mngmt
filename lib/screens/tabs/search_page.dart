import 'package:flutter/material.dart';

// ignore: camel_case_types
class notes_page extends StatefulWidget {
  const notes_page({super.key});

  @override
  State<notes_page> createState() => _notes_pageState();
}

// ignore: camel_case_types
class _notes_pageState extends State<notes_page> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: SizedBox(
        height: height,
        width: width,
      ),
    );
  }
}
