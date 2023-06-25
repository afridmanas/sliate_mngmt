import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Home_page extends StatefulWidget {
  const Home_page({
    Key? key,
  }) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  final double totalWeeks = 15 / 10;
  final double completedWeeks = 13 / 10;
  String? name;
  Timer? _refreshTimer;
  List<String> imageUrls = [];
  List<String> alert_title = [];
  List<String> alert_description = [];
  List<Map<String, dynamic>> taskDetails = [];
  String currentUserDepartment = '';
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetch_alert();
    fetchText();
    startAutoRefresh();
    getImageUrls();
    fetching_firebase();
  }

  @override
  void dispose() {
    cancelAutoRefresh();
    super.dispose();
  }

  void startAutoRefresh() {
    const refreshDuration = Duration(minutes: 1);
    _refreshTimer = Timer.periodic(refreshDuration, (_) {
      refreshData();
    });
  }

  void cancelAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  Future<void> fetching_firebase() async {
    await fetchCurrentUserDetails();
    await fetch_alert();
    fetchText();
  }

  Future<void> fetchCurrentUserDetails() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('/users/login_form/students')
          .doc(user.uid)
          .get();
      final userData = userSnapshot.data();
      if (userData != null) {
        setState(() {
          currentUserDepartment = userData['department'];
        });
      }
    }
  }

  Future<void> fetchText() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final collection =
          FirebaseFirestore.instance.collection('/users/login_form/students');
      final document = collection.doc(user.uid);
      final snapshot = await document.get();
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!['fullName'];
        });
      }
    }
  }

  Future<void> fetch_alert() async {
    final taskSnapshot = await FirebaseFirestore.instance
        .collection('tasks')
        .where('department', isEqualTo: currentUserDepartment)
        .get();

    if (taskSnapshot.docs.isNotEmpty) {
      List<String> titles = taskSnapshot.docs.map((doc) {
        String title = doc.get('title') as String;
        return title;
      }).toList();
      setState(() {
        alert_title = titles;
      });
    } else {
      setState(() {
        alert_title = ['No alert available'];
      });
    }
  }

  Future<void> getImageUrls() async {
    final ListResult result =
        await FirebaseStorage.instance.ref().child('/news_feed').listAll();
    final List<Reference> allImages = result.items;
    final List<String> urls = await Future.wait(
        allImages.map((Reference ref) => ref.getDownloadURL()));
    setState(() {
      imageUrls = urls;
    });
  }

  Future<void> refreshData() async {
    await fetch_alert();
    await getImageUrls();
    await fetchText();
  }

  @override
  Widget build(BuildContext context) {
    double totalWeeks = 22;
    double completedWeeks = 19;
    double academicProgressPercent = completedWeeks / totalWeeks;
    double balanceWeeks = totalWeeks - completedWeeks;

    double width = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: refreshData,
      child: ListView(
        children: [
          Padding(
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
                        'Hey ${name ?? ''}',
                        style: GoogleFonts.mavenPro(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'Lets Explore SLIATE',
                        style: GoogleFonts.mavenPro(
                          textStyle: TextStyle(
                            color: text_clr,
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
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
                            lineWidth: 12.0,
                            animation: true,
                            startAngle: 0,
                            percent: academicProgressPercent,
                            center: Text(
                              '${(academicProgressPercent * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.black,
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Completed Weeks: $completedWeeks'),
                                    Text('Balance Weeks: $balanceWeeks'),
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
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Task Bar',
                        style: GoogleFonts.mavenPro(
                          textStyle: TextStyle(
                            color: text_clr,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 100,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.90,
                            enableInfiniteScroll: true,
                            autoPlayInterval: const Duration(seconds: 7),
                            enlargeCenterPage: true,
                            scrollDirection: Axis.vertical,
                          ),
                          items: List.generate(
                            alert_title.isNotEmpty ? alert_title.length : 1,
                            (index) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  width: 1,
                                ),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '19',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            ' June',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          if (alert_title.isNotEmpty)
                                            Text(
                                              alert_title[index],
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          if (alert_description.isNotEmpty)
                                            Text(
                                              alert_description[index],
                                              softWrap: true,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Latest Feeds',
                        style: GoogleFonts.mavenPro(
                          textStyle: TextStyle(
                            color: text_clr,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true,
                autoPlayInterval: const Duration(seconds: 10),
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: imageUrls.map((String url) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
