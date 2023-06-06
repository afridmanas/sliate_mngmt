import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconly/iconly.dart';
import 'package:sliate/event%20_test.dart';
import 'package:sliate/screens/widgets/json.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkModeEnabled = false;
  final bool _isNotificationEnabled = true;
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: ListView(
            children: [
              const Center(
                child: Text(
                  'Settings',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                leading: const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(
                    'assets/images/logo/manas.jpg',
                  ),
                ),
                title: Text(
                  'manas',
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                subtitle: const Text('SAM/IT/2020/F/0024'),
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        IconlyLight.notification,
                      ),
                      title: const Text('Dark Mode'),
                      trailing: Switch(
                        value: _isDarkModeEnabled,
                        onChanged: (value) {
                          setState(() {
                            _isDarkModeEnabled = value;
                          });
                        },
                      ),
                    ),
                    const ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text('Notifications'),
                      trailing: Icon(
                        IconlyLight.notification,
                        size: 18,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.account_circle),
                      title: const Text('Account Preferences'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => json()),
                        );
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 18,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.person_add),
                      title: const Text('Invite a Friend'),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => ContainerPage()),
                        // );
                      },
                      trailing: const Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 18,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Sign Out'),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
