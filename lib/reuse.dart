import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliate/screens/Notes/Course_page.dart';
import 'package:sliate/screens/categories/devoloper.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sliate/screens/Notes/notes_home.dart';
import 'package:sliate/screens/Notes/pastpaper.dart';
import 'package:sliate/screens/categories/events.dart';
import 'package:sliate/screens/categories/settings.dart';
import 'package:sliate/screens/categories/staff.dart';
import 'package:sliate/screens/home/Notes_page.dart';
import 'package:sliate/screens/log/login_page.dart';
import 'package:sliate/screens/widgets/demo.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Hero(
            tag: 'imageHero',
            child: Image.asset(
              'assets/images/logo/manas.jpg',
            )),
      ),
    );
  }
}

// ignore: camel_case_types
class drawer extends StatelessWidget {
  const drawer({
    super.key,
  });

  void handleLogout(BuildContext context) {
    FirebaseAuth.instance.signOut().then((_) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.remove('isLoggedIn');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => sign_in()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 55.0, top: 35),
              child: Text(
                'SLIATE',
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
          ),
          ListTile(
            title: const Text('Notes'),
            leading: const Icon(
              Icons.note_alt_sharp,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Notes_Page()),
              );
            },
          ),
          ListTile(
            title: const Text('Managment Staff'),
            leading: const Icon(
              Icons.newspaper,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const staff()),
              );
            },
          ),
          ListTile(
              title: const Text('Test'),
              leading: const Icon(
                Icons.info,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StaggeredGridPage(),
                  ),
                );
              }),
          ListTile(
              title: const Text('Academic Notes'),
              leading: const Icon(
                Icons.info,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Notes_home(),
                  ),
                );
              }),
          ListTile(
              title: const Text('Course Modules'),
              leading: const Icon(
                IconlyLight.document,
              ),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const CourseDetailsPage(),
                //   ),
                // );
              }),
          ListTile(
              title: const Text('Settings'),
              leading: const Icon(
                IconlyLight.setting,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              }),
          // ListTile(
          //     title: const Text('Events'),
          //     leading: const Icon(
          //       Icons.info,
          //     ),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const Events(),
          //         ),
          //       );
          //     }),
          ListTile(
              title: const Text('Past Papers'),
              leading: const Icon(
                IconlyLight.paper,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PassPaperList(),
                  ),
                );
              }),
          ListTile(
              title: const Text('Developer Info'),
              leading: const Icon(
                IconlyLight.profile,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeveloperInfoPage(),
                  ),
                );
              }),
          ListTile(
              title: const Text('Log Out'),
              leading: const Icon(
                IconlyLight.logout,
              ),
              onTap: () {
                handleLogout(context);
              }),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class nav_bar extends StatefulWidget {
  const nav_bar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _nav_barState createState() => _nav_barState();
}

// ignore: camel_case_types
class _nav_barState extends State<nav_bar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: GNav(
          rippleColor: Colors.grey[300]!,
          hoverColor: Colors.grey[100]!,
          gap: 8,
          activeColor: Colors.black,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: Colors.grey[100]!,
          color: Colors.black,
          tabs: const [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.heart,
              text: 'Likes',
            ),
            GButton(
              icon: LineIcons.search,
              text: 'Search',
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
          },
        ),
      ),
    );
  }
}
