import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class notes_page extends StatefulWidget {
  const notes_page({super.key});

  @override
  State<notes_page> createState() => _notes_pageState();
}

class _notes_pageState extends State<notes_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Available Notes',
            style: GoogleFonts.mavenPro(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  height: 140,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // color: secondary,
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/logo/manas.jpg',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 140,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // color: secondary,
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/logo/manas.jpg',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 70,
                  width: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // color: secondary,
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/logo/manas.jpg',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 70,
                  width: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // color: secondary,
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/logo/manas.jpg',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
