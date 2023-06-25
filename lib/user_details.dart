
import 'package:firebase_auth/firebase_auth.dart';
class user_details {
  final FirebaseAuth firebase = FirebaseAuth.instance;
 User? user;

  Future<void> fetchUserDetails() async {
    user = firebase.currentUser;
  }

  User? get currentUser => user;
  
}