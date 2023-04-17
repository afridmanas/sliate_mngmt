import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';
import 'package:sliate/reuse.dart';
import 'package:sliate/screens/home/news_veiw.dart';
import 'package:sliate/screens/navigation_bar/profile.dart';

// ignore: camel_case_types
class home_design1 extends StatefulWidget {
  const home_design1({super.key});

  @override
  State<home_design1> createState() => _home_design1State();
}

// ignore: camel_case_types
class _home_design1State extends State<home_design1> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: SizedBox(
            width: 50.0,
            height: 50.0,
            child: IconButton(
              icon: const Icon(
                Icons.menu_sharp,
                color: Colors.black,
              ),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
          ),
          backgroundColor: bg,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const profile()),
                  );
                },
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(25)),
                  child: Image.asset(
                    'assets/images/logo/manas.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: bg,
        drawer: const drawer(),
        body: const hm_ds_1(),
        bottomNavigationBar: nav_bar(),
      ),
    );
  }
}

// ignore: camel_case_types
class hm_ds_1 extends StatefulWidget {
  const hm_ds_1({
    super.key,
  });

  @override
  State<hm_ds_1> createState() => _hm_ds_1State();
}

// ignore: camel_case_types
class _hm_ds_1State extends State<hm_ds_1> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hey Manas',
              style: GoogleFonts.mavenPro(
                textStyle: const TextStyle(
                  color: text,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              'Lets Explore SLIATE',
              style: GoogleFonts.mavenPro(
                textStyle: const TextStyle(
                  color: text,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: bg,
                        labelText: 'Search Here',
                        // hintText: 'Search Here',
                        prefixIcon: const Icon(Icons.search_sharp),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    height: 45,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      border: Border.all(
                        color: secondary,
                        width: 1.0,
                      ),
                    ),
                    child: const Icon(Icons.filter_alt_rounded)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: secondary,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'System Analysis',
                        style: GoogleFonts.patuaOne(
                          textStyle: const TextStyle(
                            color: text,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: secondary,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Data Structure',
                        style: GoogleFonts.patuaOne(
                          textStyle: const TextStyle(
                            color: text,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: secondary,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Object Oriented',
                        style: GoogleFonts.patuaOne(
                          textStyle: const TextStyle(
                            color: text,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: secondary,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Disaster Recovery',
                        style: GoogleFonts.patuaOne(
                          textStyle: const TextStyle(
                            color: text,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.black,
            ),
            Text(
              'Popular Subjects',
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
                      color: secondary,
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
                      color: secondary,
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
                      color: secondary,
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
                      color: secondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              color: text,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: secondary,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              color: text,
            ),
            Text(
              'Latest News',
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
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const news_veiw()),
                      ),
                    );
                  },
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: secondary,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: secondary,
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/logo/manas.jpg',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Expanded(
                            child: Text(
                                'The Academic will be Start on Next Monday'))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const news_veiw()),
                      ),
                    );
                  },
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: secondary,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: secondary,
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/logo/manas.jpg',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Expanded(
                            child: Text(
                                'The Academic will be Start on Next Monday'))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const news_veiw()),
                      ),
                    );
                  },
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: secondary,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: secondary,
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/logo/manas.jpg',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Expanded(
                          child: Text(
                              'The Academic will be Start on Next Monday'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
