import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:sliate/reuse.dart';
import 'package:sliate/screens/navigation_bar/Events/events_page.dart';
import 'package:sliate/screens/navigation_bar/Home/home_page.dart';
import 'package:sliate/screens/navigation_bar/NewsFeed/newsfeed.dart';
import 'package:sliate/screens/navigation_bar/Settings/settings.dart';
import 'package:sliate/screens/widgets/drawer.dart';

class user_dashboard extends StatefulWidget {
  const user_dashboard({super.key});

  @override
  State<user_dashboard> createState() => _user_dashboardState();
}

// ignore: camel_case_types
class _user_dashboardState extends State<user_dashboard> {
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
            children: const [
              Home_page(),
              newsfeed(),
              Events_page(),
              SettingsPage()
            ],
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
