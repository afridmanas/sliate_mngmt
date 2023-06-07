import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sliate/screens/widgets/json.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkModeEnabled = false;
  bool _isNotificationEnabled = true;
  String? text;

  @override
  void initState() {
    super.initState();
    fetchText();
  }

  Future<void> fetchText() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final collection = FirebaseFirestore.instance.collection('users');
      final document = collection.doc(user.uid);
      final snapshot = await document.get();
      if (snapshot.exists) {
        setState(() {
          text = snapshot.data()!['name'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Text(
              'Settings',
              style: GoogleFonts.mavenPro(
                textStyle: const TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: ListView(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Colors.blue,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: const Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(
                            'assets/images/logo/manas.jpg',
                          ),
                        ),
                        title: Text(
                          'Manas Afrid',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        subtitle: Text('SAM/IT/2020/F/0024'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'General',
                    style: GoogleFonts.mavenPro(
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .5),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Colors.blue,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              children: [
                                const ListTile(
                                  leading: Icon(
                                    LineIcons.user,
                                  ),
                                  title: Text('Account Information'),
                                  trailing: Icon(
                                    LineIcons.arrowCircleDown,
                                    size: 25,
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(
                                    LineIcons.moon,
                                  ),
                                  title: const Text('Dark Mode '),
                                  trailing: Switch(
                                    activeTrackColor: Colors.blue,
                                    value: _isDarkModeEnabled,
                                    onChanged: (value) {
                                      setState(() {
                                        _isDarkModeEnabled = value;
                                      });
                                    },
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(
                                    LineIcons.bell,
                                  ),
                                  title: const Text('Notification'),
                                  // onTap: () {
                                  //   // Navigator.push(
                                  //   //   context,
                                  //   //   MaterialPageRoute(
                                  //   //       builder: (context) => ContainerPage()),
                                  //   // );
                                  // },
                                  trailing: Switch(
                                    activeTrackColor: Colors.blue,
                                    value: _isNotificationEnabled,
                                    onChanged: (value) {
                                      setState(() {
                                        _isNotificationEnabled = value;
                                      });
                                    },
                                  ),
                                ),
                                const Divider(),
                                const ListTile(
                                  leading: Icon(
                                    LineIcons.facebookMessenger,
                                  ),
                                  title: Text('Send Feedback'),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(
                                    LineIcons.alternateSignOut,
                                  ),
                                  title: const Text('Sign Out'),
                                  onTap: () async {
                                    await FirebaseAuth.instance.signOut();
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountPreferencesPage extends StatelessWidget {
  const AccountPreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Preferences'),
      ),
      body: const Center(
        child: Text('Account Preferences'),
      ),
    );
  }
}
