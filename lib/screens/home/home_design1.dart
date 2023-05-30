import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sliate/color.dart';
import 'package:sliate/reuse.dart';
import 'package:sliate/screens/home/news_veiw.dart';
import 'package:sliate/screens/home/Notes_page.dart';
import 'package:sliate/screens/tabs/notes_page.dart';
import 'package:sliate/screens/widgets/drop_down.dart';

// ignore: camel_case_types
class home_design1 extends StatefulWidget {
  const home_design1({super.key});

  @override
  State<home_design1> createState() => _home_design1State();
}

// ignore: camel_case_types
class _home_design1State extends State<home_design1> {
  int _selectedIndex = 0;
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: const [dropmenu()],
        ),
        backgroundColor: Colors.white,
        drawer: const drawer(),
        body: IndexedStack(
          index: _selectedIndex,
          children: const [hm_ds_1(), userpage(), notes_page()],
        ),
        bottomNavigationBar: bottom_nav_bar(),
      ),
    );
  }

  GNav bottom_nav_bar() {
    return GNav(
        rippleColor: Colors.grey[300]!,
        hoverColor: Colors.grey[100]!,
        gap: 8,
        activeColor: Colors.black,
        iconSize: 24,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: const Duration(milliseconds: 400),
        tabBackgroundColor: Colors.grey[100]!,
        color: Colors.black,
        tabs: const [
          GButton(
            icon: LineIcons.home,
            text: 'Home',
          ),
          GButton(
            icon: LineIcons.book,
            text: 'Notes',
          ),
          GButton(
            icon: LineIcons.hackerNews,
            text: 'Newsfeed',
          ),
          GButton(
            icon: LineIcons.user,
            text: 'Profile',
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        });
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('This is the search page'),
    );
  }
}

class userpage extends StatelessWidget {
  const userpage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('This is the profile page'),
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
                  color: Colors.black,
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
            const Divider(
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Notes_Page()),
                    );
                  },
                  child: Text(
                    'See All',
                    style: GoogleFonts.mavenPro(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 75,
                    margin: const EdgeInsets.all(8),
                    color: Colors.redAccent,
                    child: Center(
                      child: Text(
                        'Box ${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 5,
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
                borderRadius: BorderRadius.circular(10),
                // color: secondary,
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/logo/manas.jpg',
                  ),
                  fit: BoxFit.fitWidth,
                ),
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
                          child:
                              Text('The Academic will be Start on Next Monday'),
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
