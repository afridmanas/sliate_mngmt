import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconly/iconly.dart';
import 'package:sliate/screens/widgets/json.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkModeEnabled = false;
  bool _isNotificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: ListView(
            children: [
              Center(
                child: Text(
                  'Settings',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              const ListTile(
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
                trailing: Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 18,
                ),
              ),
              SizedBox(
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
                      onTap: () {},
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
