import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:sliate/screens/Notes/it/notes_hndit.dart';
import 'package:sliate/screens/categories/navigation_bar/Events/events_page.dart';
import 'package:sliate/screens/categories/navigation_bar/Home/home_page.dart';
import 'package:sliate/screens/categories/navigation_bar/NewsFeed/newsfeed.dart';
import 'package:sliate/screens/categories/navigation_bar/Settings/settings.dart';
import 'package:sliate/screens/widgets/drawer.dart';
import 'package:sliate/screens/widgets/notification_page.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setStatusBarColor();
  }

  void setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Set transparent status bar color
        statusBarIconBrightness:
            Brightness.dark, // Use dark icons for better visibility
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white, // Set your desired status bar color here
      ),
      child: WillPopScope(
        onWillPop: () async {
          bool exitConfirmation = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                title: Text(
                  'Exit App',
                  style: GoogleFonts.mavenPro(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .5),
                  ),
                ),
                content: Text(
                  'Are you sure you want to exit the app?',
                  style: GoogleFonts.mavenPro(
                    textStyle: const TextStyle(fontSize: 16, letterSpacing: .5),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.mavenPro(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            letterSpacing: .5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Exit',
                      style: GoogleFonts.mavenPro(
                        textStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: .5),
                      ),
                    ),
                    onPressed: () {
                      SystemNavigator.pop();
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Icon(
                      IconlyLight.notification,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            drawer: drawer(),
            body: IndexedStack(
              index: _selectedIndex,
              children: const [
                Home_page(),
                NewsFeed(),
                notes_hndit(),
                SettingsPage(),
              ],
            ),
            bottomNavigationBar: bottomNavigationBar(),
          ),
        ),
      ),
    );
  }

  Padding bottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        top: 10,
        left: 20,
        right: 20,
      ),
      child: GNav(
        rippleColor: Colors.grey[300]!,
        hoverColor: Colors.grey[100]!,
        gap: 5,
        padding: const EdgeInsets.only(
          bottom: 5,
          top: 5,
          left: 10,
          right: 10,
        ),
        tabBorderRadius: 10,
        activeColor: Colors.black,
        iconSize: 24,
        duration: const Duration(milliseconds: 400),
        tabBackgroundColor: Colors.grey[100]!,
        color: Colors.black,
        tabs: const [
          GButton(
            icon: IconlyLight.home,
            text: 'Home',
          ),
          GButton(
            icon: IconlyLight.message,
            text: 'News Feed',
          ),
          GButton(
            icon: IconlyLight.document,
            text: 'Notes',
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
    );
  }
}
