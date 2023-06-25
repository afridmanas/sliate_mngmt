// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:iconly/iconly.dart';

// class BottomNavigation extends StatefulWidget {
//   const BottomNavigation({Key? key}) : super(key: key);

//   @override
//   State<BottomNavigation> createState() => _BottomNavigationState();
// }

// class _BottomNavigationState extends State<BottomNavigation> {
//   int _selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return GNav(
//       rippleColor: Colors.grey[300]!,
//       hoverColor: Colors.grey[100]!,
//       gap: 8,
//       tabMargin: EdgeInsets.only(
//         bottom: 5,
//         top: 5,
//       ),

//       activeColor: Colors.black,
//       iconSize: 24,

//       duration: const Duration(milliseconds: 400),
//       //tabBackgroundColor: Colors.grey[100]!,
//       color: Colors.black,
//       tabs: const [
//         GButton(
//           padding: EdgeInsets.only(
//             bottom: 5,
//             top: 5,
//           ),
//           icon: IconlyLight.home,
//           text: 'Home',
//         ),
//         GButton(
//           padding: EdgeInsets.only(
//             bottom: 5,
//             top: 5,
//           ),
//           icon: IconlyLight.message,
//           text: 'News',
//         ),
//         GButton(
//           padding: EdgeInsets.only(
//             bottom: 5,
//             top: 5,
//           ),
//           icon: IconlyLight.discovery,
//           text: 'Albums',
//         ),
//         GButton(
//           padding: EdgeInsets.only(
//             bottom: 5,
//             top: 5,
//           ),
//           icon: IconlyLight.setting,
//           text: 'Settings',
//         ),
//       ],
//       selectedIndex: _selectedIndex,
//       onTabChange: (index) {
//         setState(
//           () {
//             _selectedIndex = index;
//           },
//         );
//       },
//     );
//   }
// }
