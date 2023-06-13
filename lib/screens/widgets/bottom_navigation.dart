import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconly/iconly.dart';

class BottomNavigation extends StatefulWidget {
const BottomNavigation({ Key? key }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
   int _selectedIndex = 0;
  @override
  Widget build(BuildContext context){
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
        setState(
          () {
            _selectedIndex = index;
          },
        );
      },
    );
  }
}