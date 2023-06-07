import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:line_icons/line_icons.dart';

import 'package:sliate/color.dart';
import 'package:sliate/reuse.dart';
import 'package:sliate/screens/navigation_bar/NewsFeed/newsfeed.dart';

import 'package:sliate/screens/navigation_bar/Events/events.dart';
import 'package:sliate/screens/navigation_bar/Settings/settings.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:sliate/screens/quick%20widgets/download_forms.dart';
import 'package:sliate/screens/quick%20widgets/lectures.dart';
import 'package:sliate/screens/quick%20widgets/library.dart';
import 'package:sliate/screens/quick%20widgets/results.dart';
import 'package:sliate/screens/quick%20widgets/website.dart';

import '../Events/events_page.dart';

// ignore: camel_case_types

// ignore: camel_case_types
class Home_page extends StatefulWidget {
  const Home_page({
    super.key,
  });

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
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
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Column(
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
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 3), // changes position of shadow
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
                              fontWeight: FontWeight.bold, fontSize: 20.0),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Completed Weeks: 11'),
                                Text('Balance Weeks: 4'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Categories',
                  style: GoogleFonts.mavenPro(
                    textStyle: const TextStyle(
                      color: text_color,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
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
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Library()),
                            );
                          },
                          icon: Icon(
                            LineIcons.book,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DownloadForms()),
                            );
                          },
                          icon: Icon(
                            LineIcons.download,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Results()),
                            );
                          },
                          icon: Icon(
                            LineIcons.database,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Website()),
                            );
                          },
                          icon: Icon(
                            LineIcons.link,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Lectures()),
                            );
                          },
                          icon: Icon(
                            LineIcons.userAstronaut,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Lectures()),
                            );
                          },
                          icon: Icon(
                            LineIcons.userAstronaut,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                height: double.infinity,
                autoPlay: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.99,
                enableInfiniteScroll: true,
                autoPlayInterval: const Duration(seconds: 10),
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: List.generate(
                5,
                (index) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(
                    bottom: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      'https://blogger.googleusercontent.com/img/a/AVvXsEgSk6w-V-t3COB0n59F8-eJHAG_m1BVdeT5_W_uoF7P7emZTK7aPXhLksdnvw7RZTE6OFDytuAAlLVBkY5UxK23qREva0E4pkMrRnciLi72U2o-hgYXQLzC6D3MLvSOOyU7csGZIWOjTGgw6eO8pfc1MG3m9xjHpYQYFaoS3rc79cCQ44_NG3Y9v0vH=s16000',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
