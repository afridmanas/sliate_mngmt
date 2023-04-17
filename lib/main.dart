import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliate/screens/start/splash_screen.dart';

import 'color.dart';

void main() async {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: bg,
      systemNavigationBarColor: Colors.black,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SLIATE',
      home: Scaffold(
        body: splash_screen(),
      ),
    );
  }
}
