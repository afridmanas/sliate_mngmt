import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';
import 'package:sliate/screens/categories/log/student/hnda_signup.dart';
import 'package:sliate/screens/categories/log/student/hnde_signup.dart';
import 'package:sliate/screens/categories/log/student/hndit_signup.dart';

class check_department extends StatefulWidget {
  const check_department({Key? key}) : super(key: key);

  @override
  State<check_department> createState() => _check_departmentState();
}

class _check_departmentState extends State<check_department> {
  bool hndeCardTapped = false;
  bool hnditCardTapped = false;
  bool hndaCardTapped = false;

  late String usertype;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: bg_clr,
        appBar: AppBar(
          iconTheme: IconThemeData(color: text_clr),
          elevation: 0,
          backgroundColor: bg_clr,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                child: Text(
                  'Choose your Department ?',
                  style: GoogleFonts.mavenPro(
                    textStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .5),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        usertype = 'hndit';
                        hndeCardTapped = false;
                        hnditCardTapped = true;
                        hndaCardTapped = false;
                      });
                    },
                    child: Card(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: hnditCardTapped ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            'HNDIT',
                            style: GoogleFonts.mavenPro(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: .5,
                                color: hnditCardTapped
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        usertype = 'hnde';
                        hndeCardTapped = true;
                        hnditCardTapped = false;
                        hndaCardTapped = false;
                      });
                    },
                    child: Card(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: hndeCardTapped ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            'HNDE',
                            style: GoogleFonts.mavenPro(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: hndeCardTapped
                                    ? Colors.white
                                    : Colors.black,
                                letterSpacing: .5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        usertype = 'hnda';
                        hndeCardTapped = false;
                        hnditCardTapped = false;
                        hndaCardTapped = true;
                      });
                    },
                    child: Card(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: hndaCardTapped ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            'HNDA',
                            style: GoogleFonts.mavenPro(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: .5,
                                color: hndaCardTapped
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // fixedSize: const Size(400, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.grey, width: 1),
                    ),
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.all(10),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (usertype == 'hndit') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => hndit_signup()),
                        ),
                      );
                    } else if (usertype == 'hnde') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => hnde_signup()),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => hnda_signup()),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Craete an account',
                    style: GoogleFonts.mavenPro(
                      textStyle: TextStyle(
                          fontSize: 14,
                          color: bg_clr,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .5),
                    ),
                  )),
              const SizedBox(height: 30),
            ],
          ),
        ));
  }
}
