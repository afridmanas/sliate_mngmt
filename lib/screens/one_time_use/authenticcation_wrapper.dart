// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sliate/admin/admin_dashboard.dart';
// import 'package:sliate/screens/log/signup_page.dart';
// import 'package:sliate/users/user_dashboard.dart';

// class AuthenticationWrapper extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: _auth.authStateChanges(),
//       builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           User? user = snapshot.data;
//           if (user == null) {
//             return const sign_up();
//           } else {
//             return FutureBuilder<DocumentSnapshot>(
//               future: FirebaseFirestore.instance
//                   .collection('users')
//                   .doc(user.uid)
//                   .get(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<DocumentSnapshot> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   Map<String, dynamic> data =
//                       snapshot.data!.data() as Map<String, dynamic>;
//                   String role = data['role'];

//                   if (role == 'admin') {
//                     return const admin_dashboard();
//                   } else {
//                     return const user_dashboard();
//                   }
//                 } else {
//                   return const CircularProgressIndicator();
//                 }
//               },
//             );
//           }
//         } else {
//           return const CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }

