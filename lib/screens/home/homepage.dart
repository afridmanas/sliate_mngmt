import 'package:flutter/material.dart';
import 'package:sliate/screens/home/home_body2.dart';

// ignore: camel_case_types
class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

// ignore: camel_case_types
class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: home_body(),
        backgroundColor: Colors.white,
        // drawer: drawer(),
        // bottomNavigationBar: navbar(),
      ),
    );
  }
}
