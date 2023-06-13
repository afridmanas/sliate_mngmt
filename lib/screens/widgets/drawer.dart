import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliate/screens/Notes/notes_home.dart';
import 'package:sliate/screens/Notes/pastpaper.dart';
import 'package:sliate/screens/Test/test.dart';
import 'package:sliate/screens/Test/test4.dart';
import 'package:sliate/screens/categories/devoloper.dart';
import 'package:sliate/screens/categories/staff.dart';
import 'package:sliate/screens/log/login_page.dart';
import 'package:sliate/screens/navigation_bar/Events/events_page.dart';
import 'package:sliate/screens/navigation_bar/Settings/settings.dart';
import 'package:sliate/screens/quick%20widgets/download_forms.dart';
import 'package:sliate/screens/quick%20widgets/library.dart';

class drawer extends StatelessWidget {
  const drawer({
    super.key,
  });

  void handleLogout(BuildContext context) {
    FirebaseAuth.instance.signOut().then((_) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.remove('isLoggedIn');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => sign_in()),
        );
      });
    });
  }

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
            title: const Text('Documents'),
            leading: const Icon(
              CupertinoIcons.doc,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DownloadForms()),
              );
            },
          ),

          ListTile(
              title: const Text('Library'),
              leading: const Icon(
                CupertinoIcons.collections,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const library_page(),
                  ),
                );
              }),
          ListTile(
              title: const Text('Settings'),
              leading: const Icon(
                IconlyLight.setting,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              }),
          // ListTile(
          //     title: const Text('Events'),
          //     leading: const Icon(
          //       Icons.info,
          //     ),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const Events(),
          //         ),
          //       );
          //     }),
          ListTile(
            title: const Text('Past Papers'),
            leading: const Icon(
              IconlyLight.paper,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PassPaperList(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Developer Info'),
            leading: const Icon(
              IconlyLight.profile,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeveloperInfoPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('test'),
            leading: const Icon(
              Icons.note_alt_sharp,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Test()),
              );
            },
          ),
          ListTile(
            title: const Text('jjjj'),
            leading: const Icon(
              Icons.info,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Events_page(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Academic Notes'),
            leading: const Icon(
              Icons.info,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Notes_home(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Test 4'),
            leading: const Icon(
              Icons.info,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => update_function(),
                ),
              );
            },
          ),
          ListTile(
              title: const Text('Log Out'),
              leading: const Icon(
                IconlyLight.logout,
              ),
              onTap: () {
                handleLogout(context);
              }),
        ],
      ),
    );
  }
}
