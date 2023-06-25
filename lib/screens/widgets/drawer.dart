import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliate/color.dart';
import 'package:sliate/screens/Notes/hnda/notes_hnda.dart';
import 'package:sliate/screens/Notes/hnde/notes_hnde.dart';
import 'package:sliate/screens/Notes/it/notes_hndit.dart';
import 'package:sliate/screens/Notes/courses.dart';
import 'package:sliate/screens/categories/staff.dart';
import 'package:sliate/screens/categories/log/login_page.dart';
import 'package:sliate/screens/categories/task_schedule/task_schedule.dart';
import 'package:sliate/screens/quick%20widgets/library.dart';
import 'package:sliate/screens/quick%20widgets/website.dart';
import 'package:sliate/screens/widgets/about.dart';

class drawer extends StatefulWidget {
  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  String? email;
  String? department;
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    fetchText();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  Future<void> fetchText() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final collection =
          FirebaseFirestore.instance.collection('/users/login_form/students');
      final document = collection.doc(user.uid);
      final snapshot = await document.get();
      if (_isMounted && snapshot.exists) {
        setState(() {
          email = snapshot.data()!['email'];
          department = snapshot.data()!['department'];
        });
      }
    }
  }

  void navigateToPage(Widget page) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Stack(
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.2),
                        BlendMode.xor,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: const DecorationImage(
                            image:
                                AssetImage('assets/images/sliate/sliate1.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'SLIATE',
                            style: GoogleFonts.mavenPro(
                              textStyle: TextStyle(
                                color: bg_clr,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'Sammanthurai',
                            style: GoogleFonts.mavenPro(
                              textStyle: TextStyle(
                                color: bg_clr,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ListTile(
                    title: const Text('About Story'),
                    leading: const Icon(
                      CupertinoIcons.info_circle,
                    ),
                    onTap: () {
                      navigateToPage(AboutPage());
                    },
                  ),
                  // ListTile(
                  //   title: const Text('Academic Notes'),
                  //   leading: const Icon(
                  //     CupertinoIcons.book,
                  //   ),
                  //   onTap: () {
                  //     if (department == 'HNDIT') {
                  //       navigateToPage(const notes_hndit());
                  //     } else if (department == 'HNDA') {
                  //       navigateToPage(const notes_hnda());
                  //     } else if (department == 'HNDE') {
                  //       navigateToPage(const notes_hnde());
                  //     } else {
                  //       navigateToPage(const notes_hndit());
                  //     }
                  //   },
                  // ),
                  ListTile(
                    title: const Text('Library'),
                    leading: const Icon(
                      CupertinoIcons.collections,
                    ),
                    onTap: () {
                      navigateToPage(const library_page());
                    },
                  ),
                  ListTile(
                    title: const Text('Tasks'),
                    leading: const Icon(
                      IconlyLight.work,
                    ),
                    onTap: () {
                      navigateToPage(const TaskSchedule());
                    },
                  ),
                  ListTile(
                    title: const Text('Staffs'),
                    leading: const Icon(
                      IconlyLight.user,
                    ),
                    onTap: () {
                      navigateToPage(const Staffs());
                    },
                  ),
                  ListTile(
                    title: const Text('Courses'),
                    leading: const Icon(
                      IconlyLight.chart,
                    ),
                    onTap: () {
                      navigateToPage(const course());
                    },
                  ),
                  ListTile(
                    title: const Text('Developer'),
                    leading: const Icon(
                      IconlyLight.profile,
                    ),
                    onTap: () {
                      navigateToPage(const developer());
                    },
                  ),
                  ListTile(
                    title: const Text('Log Out'),
                    leading: const Icon(
                      IconlyLight.logout,
                    ),
                    onTap: () {
                      handleLogout(context);
                    },
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ],
          ),
          Center(
            child: Text(
              'Signing as ${email ?? ''}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: text_clr,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void handleLogout(BuildContext context) async {
    FirebaseAuth.instance.signOut().then((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => sign_in()),
      );
    });
  }
}

// ListTile(
          //     title: const Text('Download'),
          //     leading: const Icon(
          //       IconlyLight.chart,
          //     ),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) =>  PDFDownloader(),
          //         ),
          //       );
          //     }),
          // ListTile(
          //   title: const Text('Staff Add'),
          //   leading: const Icon(
          //     IconlyLight.paper,
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => staff_add(),
          //       ),
          //     );
          //   },
          // ),
 // ListTile(
          //   title: const Text('Documents'),
          //   leading: const Icon(
          //     CupertinoIcons.doc,
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const DownloadForms()),
          //     );
          //   },
          // ),
// ListTile(
          //   title: const Text('News Feed Update Image'),
          //   leading: const Icon(
          //     IconlyLight.paper,
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => NewsFeedPage(),
          //       ),
          //     );
          //   },
          // ),
          // ListTile(
          //   title: const Text('Developer Info'),
          //   leading: const Icon(
          //     IconlyLight.profile,
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => DeveloperInfoPage(),
          //       ),
          //     );
          //   },
          // ),
          // ListTile(
          //   title: const Text('Add Extra Field Update'),
          //   leading: const Icon(
          //     Icons.note_alt_sharp,
          //   ),
          //   onTap: () {
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(builder: (context) => FirestoreExamplePage()),
          //     // );
          //   },
          // ),
