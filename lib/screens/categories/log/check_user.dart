// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sliate/color.dart';
// import 'package:sliate/screens/categories/log/admin/admin_signup_page.dart';
// import 'package:sliate/screens/categories/log/student/check_department.dart';
// import 'package:sliate/screens/categories/log/student/student_signup_page.dart';

// class check_user extends StatefulWidget {
//   const check_user({Key? key}) : super(key: key);

//   @override
//   State<check_user> createState() => _check_userState();
// }

// class _check_userState extends State<check_user> {
//   bool _isStudentCardTapped = false;
//   bool _isAdminCardTapped = false;
//   late String usertype;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: bg_clr,
//         appBar: AppBar(
//           iconTheme: IconThemeData(color: text_clr),
//           elevation: 0,
//           backgroundColor: bg_clr,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: Column(
//             children: [
//               const SizedBox(height: 30),
//               Container(
//                 child: Text(
//                   'Choose Your User Type?',
//                   style: GoogleFonts.mavenPro(
//                     textStyle: const TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: .5),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 50),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         usertype = 'student';
//                         _isStudentCardTapped = true;
//                         _isAdminCardTapped = false;
//                       });
//                     },
//                     child: Card(
//                       child: Container(
//                         width: 150,
//                         height: 150,
//                         decoration: BoxDecoration(
//                           color: _isStudentCardTapped
//                               ? Colors.black
//                               : Colors.white,
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Student',
//                             style: GoogleFonts.mavenPro(
//                               textStyle: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                                 letterSpacing: .5,
//                                 color: _isStudentCardTapped
//                                     ? Colors.white
//                                     : Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         usertype = 'admin';
//                         _isStudentCardTapped = false;
//                         _isAdminCardTapped = true;
//                       });
//                     },
//                     child: Card(
//                       child: Container(
//                         width: 150,
//                         height: 150,
//                         decoration: BoxDecoration(
//                           color:
//                               _isAdminCardTapped ? Colors.black : Colors.white,
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Admin',
//                             style: GoogleFonts.mavenPro(
//                               textStyle: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                                 color: _isAdminCardTapped
//                                     ? Colors.white
//                                     : Colors.black,
//                                 letterSpacing: .5,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 50),
//               ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     // fixedSize: const Size(400, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       side: const BorderSide(color: Colors.grey, width: 1),
//                     ),
//                     backgroundColor: Colors.black,
//                     padding: const EdgeInsets.all(10),
//                     textStyle: const TextStyle(
//                         fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   onPressed: () {
//                     if (usertype == 'admin') {
                     
//                     } else {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: ((context) => const check_department()),
//                         ),
//                       );
//                     }
//                   },
//                   child: Text(
//                     'Craete an account',
//                     style: GoogleFonts.mavenPro(
//                       textStyle: TextStyle(
//                           fontSize: 14,
//                           color: bg_clr,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: .5),
//                     ),
//                   )),
//               const SizedBox(height: 30),
//             ],
//           ),
//         ));
//   }
// }
