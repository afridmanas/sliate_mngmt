import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';
import 'package:sliate/screens/categories/log/login_page.dart';

class ChangePasswordPage extends StatelessWidget {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController Confirm_newPassword = TextEditingController();

  void changePassword(BuildContext context) async {
    String newPassword = newPasswordController.text;

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      try {
        await user.updatePassword(newPassword);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => sign_in()),
        );
      } catch (e) {
        // Handle password change error
        SnackBar(
          content: Text(
            e.toString(),
          ),
        );
        print('Error changing password');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change the color of the back arrow here
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Text(
              'Change Password',
              style: GoogleFonts.mavenPro(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Enter your Email Address below to receive your OTP Code.',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: newPasswordController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15.0),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          labelText: 'New Password',
                          labelStyle: TextStyle(
                              color: widg_clr,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: Confirm_newPassword,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15.0),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                              color: widg_clr,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          changePassword(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => sign_in(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(400, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side:
                                const BorderSide(color: Colors.grey, width: 1),
                          ),
                          backgroundColor: text_clr,
                          padding: const EdgeInsets.all(10),
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        child: Text(
                          'Change Password',
                          style: TextStyle(color: bg_clr),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
