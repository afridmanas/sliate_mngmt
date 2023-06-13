import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sliate/screens/details/update_onboard.dart';
import 'package:sliate/screens/widgets/edit_profile.dart';
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
              'Profile',
              style: GoogleFonts.mavenPro(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 35,
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
              // padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: ListView(
                children: [
                  Container(
                    child: const ListTile(
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage(
                          'assets/images/logo/manas.jpg',
                        ),
                      ),
                      title: Text(
                        'Manas Afrid',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text('SAM/IT/2020/F/0024'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Text(
                                  'General',
                                  style: GoogleFonts.mavenPro(
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: .5),
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(
                                  LineIcons.user,
                                  color: Colors.blue,
                                ),
                                title: const Text('Account Preference'),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => UserDetailsPage()),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ListTile(
                                leading: const Icon(
                                  LineIcons.moon,
                                  color: Colors.blue,
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
                              ListTile(
                                leading: const Icon(
                                  LineIcons.bell,
                                  color: Colors.blue,
                                ),
                                title: const Text('Notification'),
                                trailing: Switch(
                                  activeTrackColor: Colors.blue,
                                  value: _isNotificationEnabled,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        _isNotificationEnabled = value;
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Text(
                                  'Other',
                                  style: GoogleFonts.mavenPro(
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: .5),
                                  ),
                                ),
                              ),
                              const ListTile(
                                leading: Icon(
                                  LineIcons.helpingHands,
                                  color: Colors.blue,
                                ),
                                title: Text('FAQ'),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                ),
                              ),
                              const ListTile(
                                leading: Icon(
                                  LineIcons.telegram,
                                  color: Colors.blue,
                                ),
                                title: Text('Help & Support'),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                ),
                              ),
                              ListTile(
                                leading: const Icon(
                                  LineIcons.alternateSignOut,
                                  color: Colors.blue,
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
