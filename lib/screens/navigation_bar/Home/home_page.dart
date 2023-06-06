import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sliate/color.dart';

class home_page extends StatefulWidget {
  const home_page({
    super.key,
  });

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          height: 140,
                          width: 300,
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
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
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          height: 140,
                          width: 300,
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
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
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          height: 140,
                          width: 300,
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
