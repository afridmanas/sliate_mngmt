import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sliate/screens/log/login_page.dart';

// ignore: camel_case_types
class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

// ignore: camel_case_types
class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  // Function to navigate to the home screen after some delay
  startTimer() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  // Function to route to the home screen
  route() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const sign_in()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.jpg',
          width: 150,
          height: 120,
        ),
      ),
    );
  }
}
