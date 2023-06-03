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
import 'package:sliate/screens/categories/events.dart';
import 'package:sliate/screens/categories/newsfeed.dart';
import 'package:sliate/screens/categories/settings.dart';
import 'package:sliate/screens/home/news_veiw.dart';
import 'package:sliate/screens/home/Notes_page.dart';
import 'package:sliate/screens/tabs/notes_page.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
            children:  [hm_ds_1(), newsfeed(), Events(), SettingsPage()],
          ),
          bottomNavigationBar: bottom_nav_bar(),
        ),
      ),
    );
  }

  GNav bottom_nav_bar() {
    return GNav(
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
          setState(() {
            _selectedIndex = index;
          });
        });
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('This is the search page'),
    );
  }
}

class userpage extends StatelessWidget {
  const userpage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('This is the profile page'),
    );
  }
}

// ignore: camel_case_types
class hm_ds_1 extends StatefulWidget {
  const hm_ds_1({
    super.key,
  });

  @override
  State<hm_ds_1> createState() => _hm_ds_1State();
}

class _hm_ds_1State extends State<hm_ds_1> {
  final double totalWeeks = 15 / 10;
  final double completedWeeks = 13 / 10;
  String? text;

  @override
  void initState() {
    super.initState();
    fetchText();
  }

  Future<void> fetchText() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final collection = FirebaseFirestore.instance.collection('users');
      final document = collection.doc(user.uid);
      final snapshot = await document.get();
      if (snapshot.exists) {
        setState(() {
          text = snapshot.data()!['name'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = completedWeeks / totalWeeks;
    double textint = progress * 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hey ${text ?? ''}',
                        style: GoogleFonts.mavenPro(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        'Lets Explore SLIATE',
                        style: GoogleFonts.mavenPro(
                          textStyle: const TextStyle(
                            color: text_color,
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            child: CircularPercentIndicator(
                              radius: 65.0,
                              restartAnimation: true,
                              lineWidth: 15.0,
                              animation: true,
                              percent: progress,
                              center: Text(
                                '${textint.toStringAsPrecision(2)}%',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: Colors.blue,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Academic Progress',
                                  style: GoogleFonts.mavenPro(
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Completed Weeks: 11'),
                                      Text('Balance Weeks: 4'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Quick Categories',
                    style: GoogleFonts.mavenPro(
                      textStyle: const TextStyle(
                        color: text_color,
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Card(
                                child: Icon(
                                  IconlyLight.search,
                                  size: 40,
                                ),
                              ),
                              Card(
                                child: Icon(
                                  IconlyLight.search,
                                  size: 40,
                                ),
                              ),
                              Card(
                                child: Icon(
                                  IconlyLight.search,
                                  size: 40,
                                ),
                              ),
                              Card(
                                child: Icon(
                                  IconlyLight.search,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Card(
                                child: Icon(
                                  IconlyLight.document,
                                  size: 40,
                                ),
                              ),
                              Card(
                                child: Icon(
                                  IconlyLight.notification,
                                  size: 40,
                                ),
                              ),
                              Card(
                                child: Icon(
                                  IconlyLight.chart,
                                  size: 40,
                                ),
                              ),
                              Card(
                                child: Icon(
                                  IconlyLight.folder,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    height: 160,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
