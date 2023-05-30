// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class newsfeed extends StatefulWidget {
  const newsfeed({super.key});

  @override
  State<newsfeed> createState() => _newsfeedState();
}

class _newsfeedState extends State<newsfeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change the color of the back arrow here
        ),
      ),
      // ignore: prefer_const_constructors
      body: Center(
          child: const Text('newsfeed Page')),
    );
  }
}
