import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sliate/screens/categories/department.dart';
import 'package:sliate/screens/categories/devoloper.dart';
import 'package:sliate/screens/categories/newsfeed.dart';
import 'package:sliate/screens/categories/notes.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sliate/screens/categories/staff.dart';

// ignore: camel_case_types
class title_text extends StatelessWidget {
  const title_text({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'User Login Page',
      style: TextStyle(
          fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}

// ignore: camel_case_types
class button extends StatefulWidget {
  const button({super.key});

  @override
  State<button> createState() => _buttonState();
}

// ignore: camel_case_types
class _buttonState extends State<button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Colors.blue), // Set button color
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Set button border radius
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(
              horizontal: 50, vertical: 15), // Set button padding
        ),
      ),
      child: const Text(
        'Sign In', // Button text
        style: TextStyle(
          fontSize: 18, // Set text font size
          fontWeight: FontWeight.bold, // Set text font weight
          color: Colors.white, // Set text color
        ),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Sign In',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Hero(
            tag: 'imageHero',
            child: Image.asset(
              'assets/images/logo/manas.jpg',
            )),
      ),
    );
  }
}

// ignore: camel_case_types
class drawer extends StatelessWidget {
  const drawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 55.0, top: 35),
              child: Text(
                'SLIATE',
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.book,
            ),
            title: const Text('News Feed'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const newsfeed(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Notes'),
            leading: const Icon(
              Icons.note_alt_sharp,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const notes()),
              );
            },
          ),
          ListTile(
            title: const Text('Lecturers'),
            leading: const Icon(
              Icons.supervised_user_circle_outlined,
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Managment Staff'),
            leading: const Icon(
              Icons.newspaper,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => staff()),
              );
            },
          ),
          ListTile(
            title: const Text('Departments'),
            leading: const Icon(
              Icons.settings,
            ),
            onTap: () {},
          ),
          ListTile(
              title: const Text('Coordinators'),
              leading: const Icon(
                Icons.info,
              ),
              onTap: () {}),
          ListTile(
              title: const Text('Course Modules'),
              leading: const Icon(
                Icons.info,
              ),
              onTap: () {}),
          ListTile(
              title: const Text('Events'),
              leading: const Icon(
                Icons.info,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FirebaseImagePage(
                      imageUrl: 'gs://sliate-sam.appspot.com/banner.jpg',
                    ),
                  ),
                );
              }),
          ListTile(
              title: const Text('Forms'),
              leading: const Icon(
                Icons.info,
              ),
              onTap: () {}),
          ListTile(
              title: const Text('Guidelines'),
              leading: const Icon(
                Icons.info,
              ),
              onTap: () {}),
          ListTile(
              title: const Text('Library'),
              leading: const Icon(
                Icons.info,
              ),
              onTap: () {}),
          ListTile(
              title: const Text('Navigation Map'),
              leading: const Icon(
                Icons.info,
              ),
              onTap: () {}),
          ListTile(
              title: const Text('Past Papers'),
              leading: const Icon(
                Icons.info,
              ),
              onTap: () {}),
          ListTile(
              title: const Text('Developer Info'),
              leading: const Icon(
                Icons.info,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const developer(),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class nav_bar extends StatefulWidget {
  const nav_bar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _nav_barState createState() => _nav_barState();
}

// ignore: camel_case_types
class _nav_barState extends State<nav_bar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: GNav(
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
              icon: LineIcons.heart,
              text: 'Likes',
            ),
            GButton(
              icon: LineIcons.search,
              text: 'Search',
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
          },
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 200.0,
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // Add your onPressed logic here
              Navigator.pop(context);
            },
            child: Text('Close Bottom Sheet'),
          ),
        ),
      );
    },
  );
}
