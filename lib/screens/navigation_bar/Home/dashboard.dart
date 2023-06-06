import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sliate/color.dart';
import 'package:sliate/reuse.dart';
import 'package:sliate/screens/categories/newsfeed.dart';
import 'package:sliate/screens/navigation_bar/Events/events.dart';
import 'package:sliate/screens/navigation_bar/Home/home_page.dart';
import 'package:sliate/screens/navigation_bar/Settings/settings.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sliate/screens/widgets/Events_page.dart';

// ignore: camel_case_types
class home_design1 extends StatefulWidget {
  const home_design1({super.key});

  @override
  State<home_design1> createState() => _home_design1State();
}

// ignore: camel_case_types
class _home_design1State extends State<home_design1> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exitConfirmation = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Exit App'),
              content: const Text('Are you sure you want to exit the app?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(false); // Pop the alert dialog and return false
                  },
                ),
                TextButton(
                  child: const Text('Exit'),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(true); // Pop the alert dialog and return true
                  },
                ),
              ],
            );
          },
        );

        return exitConfirmation;
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
              leading: SizedBox(
                width: 50.0,
                height: 50.0,
                child: IconButton(
                  icon: const Icon(
                    IconlyLight.more_square,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                GestureDetector(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Icon(
                        IconlyLight.notification,
                        color: Colors.black,
                        size: 30,
                      ),
                    )),
              ]),
          backgroundColor: Colors.white,
          drawer: const drawer(),
          body: IndexedStack(
            index: _selectedIndex,
            children: [
              const home_page(),
              const newsfeed(),
              Events_page(),
              //Events(),
              const SettingsPage()
            ],
          ),
          bottomNavigationBar: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            //tabBackgroundColor: Colors.grey[100]!,
            color: Colors.black,
            tabs: const [
              GButton(
                icon: IconlyLight.home,
                text: 'Home',
              ),
              GButton(
                icon: IconlyLight.message,
                text: 'News',
              ),
              GButton(
                icon: IconlyLight.discovery,
                text: 'Events',
              ),
              GButton(
                icon: IconlyLight.setting,
                text: 'Settings',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(
                () {
                  _selectedIndex = index;
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
