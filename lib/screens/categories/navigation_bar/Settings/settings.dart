import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:sliate/screens/categories/faq.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkModeEnabled = false;
  bool _isNotificationEnabled = true;
  String? name;
  String? reg_num;
  String? staff_id;

  @override
  void initState() {
    super.initState();
    fetchText_student();
  }

  Future<void> fetchText_student() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final collection =
          FirebaseFirestore.instance.collection('/users/login_form/students');
      final document = collection.doc(user.uid);
      final snapshot = await document.get();
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!['fullName'];
          reg_num = snapshot.data()!['regNumber'];
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
                  letterSpacing: .5,
                  inherit: true,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              child: ListView(
                children: [
                  Container(
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcdn2.iconfinder.com%2Fdata%2Ficons%2Favatars-99%2F62%2Favatar-370-456322-512.png&f=1&nofb=1&ipt=9e3bec3dfcbf5fd32bbf2e55575627a9f1564d0b490748c998d212a54273034a&ipo=images',
                        ),
                      ),
                      title: Text(
                        '${name ?? ''}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '${reg_num ?? ''}',
                      ),
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
                                  IconlyBold.danger,
                                ),
                                title: const Text('Dark Mode '),
                                trailing: Switch(
                                  activeTrackColor: Colors.black,
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
                                  IconlyLight.notification,
                                ),
                                title: const Text('Notification'),
                                trailing: Switch(
                                  activeTrackColor: Colors.black,
                                  value: _isNotificationEnabled,
                                  onChanged: (value) {
                                    setState(() {
                                      _isNotificationEnabled = value;
                                    });
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
                              ListTile(
                                leading: const Icon(
                                  IconlyLight.category,
                                ),
                                title: const Text('FAQ'),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => faq()),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ListTile(
                                leading: const Icon(
                                  IconlyLight.call,
                                ),
                                title: const Text('Help & Support'),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => faq()),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ListTile(
                                leading: const Icon(
                                  IconlyLight.logout,
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
  const AccountPreferencesPage({Key? key});

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
