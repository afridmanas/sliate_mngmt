import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliate/screens/categories/log/login_page.dart';
import 'package:sliate/screens/categories/navigation_bar/Home/dashboard.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("USERID");

      if (token != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => sign_in()),
        );
      }
    });
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
