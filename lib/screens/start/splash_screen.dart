import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sliate/screens/home/home_design1.dart';

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
      MaterialPageRoute(builder: (context) => const home_design1()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Image.asset(
            'assets/images/logo.jpg',
            width: 180,
            height: 150,
          ),
          // SizedBox(height: 130),
          //   SpinKitCircle(
          //     color: Colors.deepPurple,
          //     size: 30.0,
          //   ),
          // SizedBox(height: 20),
          // SpinKitChasingDots(
          //   color: Colors.deepPurple,
          //   size: 30.0,
          // ),
          //  SizedBox(height: 80),
          //   SpinKitWave(
          //     color: Colors.deepPurple,
          //     size: 30.0,
          //   ),
          const SizedBox(height: 350),
          const SpinKitFadingCube(
            color: Colors.deepPurple,
            size: 30.0,
          ),
        ],
      ),
    ));
  }
}
