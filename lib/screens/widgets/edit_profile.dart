import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15),
                  height: 130,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset('assets/images/logo/manas.jpg'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Edit Photo',
                  style: GoogleFonts.mavenPro(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .5),
                  ),
                )
              ],
            ),
            
          ),
          Column(
            children: [
              
            ],
          )
        ],
      ),
    );
  }
}
