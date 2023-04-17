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
      body: Center(
          child: Container(
        child: Text('newsfeed Page'),
      )),
    );
  }
}
