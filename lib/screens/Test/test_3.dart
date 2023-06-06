import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class test_3 extends StatefulWidget {
  const test_3({super.key});

  @override
  State<test_3> createState() => _test_3State();
}

class _test_3State extends State<test_3> {
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
