import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';

class DeveloperInfoPage extends StatefulWidget {
  @override
  _DeveloperInfoPageState createState() => _DeveloperInfoPageState();
}

class _DeveloperInfoPageState extends State<DeveloperInfoPage> {
  List project = [
    'assets/images/logo/manas.jpg',
    'assets/images/logo/manas.jpg',
    'assets/images/logo/manas.jpg',
    'assets/images/logo/manas.jpg',
    'assets/images/logo/manas.jpg',
    'assets/images/logo/manas.jpg',
  ];
  bool isHovered = false;

  void _onHover(bool hover) {
    setState(() {
      isHovered = hover;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Stack(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: height,
                      width: width,
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          'assets/images/logo/manas.jpg',
                          fit: BoxFit.cover,
                          height: height / 3 * 1.8,
                          width: double.infinity,
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 22,
                              color: bg_clr,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                      height: 330,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 35,
                          left: 30,
                          right: 30,
                        ),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Manas Afrid',
                                        style: GoogleFonts.mavenPro(
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              color: text_clr,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: .5),
                                        ),
                                      ),
                                      Text(
                                        'SAM/IT/2020/F/0024',
                                        style: GoogleFonts.mavenPro(
                                          textStyle: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: .5),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        left: 25,
                                        right: 25,
                                        top: 8,
                                        bottom: 8,
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            width: 2,
                                          )),
                                      child: Text(
                                        'Follow',
                                        style: GoogleFonts.mavenPro(
                                          textStyle: TextStyle(
                                              fontSize: 13,
                                              color: text_clr,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: .5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'My Projects',
                                style: GoogleFonts.mavenPro(
                                  textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: .5),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 75,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: project.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        SizedBox(
                                          width: 75,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.asset(
                                              project[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'About',
                                style: GoogleFonts.mavenPro(
                                  textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: .5),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Hi, My Name is Manas Afrid and I live',
                                style: GoogleFonts.mavenPro(
                                  textStyle: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: .5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                top: height / 2 - 15,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'HNDIT',
                    style: GoogleFonts.mavenPro(
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: bg_clr,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .5),
                    ),
                  ),
                  Text(
                    '2020 Batch',
                    style: GoogleFonts.mavenPro(
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: bg_clr,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .5),
                    ),
                  ),
                  Text(
                    '10K',
                    style: GoogleFonts.mavenPro(
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: bg_clr,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .5),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

