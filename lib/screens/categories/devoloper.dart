import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';

// ignore: camel_case_types
class developer extends StatefulWidget {
  const developer({super.key});

  @override
  State<developer> createState() => _developerState();
}

// ignore: camel_case_types
class _developerState extends State<developer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Developer',
          style: TextStyle(
            color: text,
            fontSize: 25,
          ),
        ),
        iconTheme: const IconThemeData(color: text),
        elevation: 0,
        backgroundColor: bg,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 25,
          right: 25,
          bottom: 25,
        ),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: bg,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo/manas.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(75),
                      bottomLeft: Radius.circular(75),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Manas Afrid',
                        style: GoogleFonts.mavenPro(
                          textStyle: const TextStyle(
                            color: text,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        'HNDIT 2020 Batch',
                        style: GoogleFonts.mavenPro(
                          textStyle: const TextStyle(
                            color: text,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
