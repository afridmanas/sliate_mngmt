import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  final List<String> contentSuggestions = [
    'SLIATE Sammanthurai is a campus of the Sri Lanka Institute of Advanced Technological Education (SLIATE). It is located in Sammanthurai, a town in the Ampara District of Sri Lanka. SLIATE Sammanthurai offers diploma and higher national diploma programs in various fields of study, including engineering, information technology, and business management. The campus provides quality technical education and training to students, preparing them for careers in their respective fields.',
    'To  Produce Competent Intellectuals for Sustainable Development',
    'To be the Center of Excellence in Providing Best Human Capital Solution',
  ];

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
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            Text(
              'Our Story',
              style: GoogleFonts.mavenPro(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .5,
                  inherit: true,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/sliate/sliate1.jpeg',
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'About Our College',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    contentSuggestions[0],
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const Text(
                    softWrap: true,
                    'Vision ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      softWrap: true,
                      contentSuggestions[1],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const Text(
                    'Mission ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      contentSuggestions[2],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 20),
                  const Text(
                    'Director Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ExpansionTile(
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://z-p3-scontent.fcmb7-1.fna.fbcdn.net/v/t1.6435-9/117773419_372154404177241_3308885761209107573_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=174925&_nc_eui2=AeF2qTwDMhi5EsXMO6AqAMQtK_E1l6oO8rkr8TWXqg7yublJKB29UyvbKKtu_xsD8FOnp37K1nNdPd5r3C1dYiWF&_nc_ohc=_DY7oxMlI6EAX-XFBJe&_nc_ht=z-p3-scontent.fcmb7-1.fna&oh=00_AfAF6KmN6YBToPW8HJHaWeqECbM0Jpg-yHEyWNNIh16KUQ&oe=64BF8FB1'),
                    ),
                    title: const Text(
                      'Mr. S.L. Musthafa',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: const Text(
                      'Director of the College',
                      style: TextStyle(fontSize: 14),
                    ),
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Address : ATI Avenue, Samanthurai'),
                            Text('Mobile  : 067-2261304 / 077-5153500'),
                            Text('Email   : atisamanthurai@sliate.ac.lk'),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      'For More Details Checkout Our Official WebSite',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
