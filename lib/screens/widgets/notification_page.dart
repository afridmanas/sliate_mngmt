import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Text(
              'Notifications',
              style: GoogleFonts.mavenPro(
                textStyle: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, Index) {
                  return const Column(
                    children: [
                      ListTile(
                        title: Text('Manas Liked your Post'),
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/logo/manas.jpg'),
                        ),
                        // onTap: () {

                        // },
                      ),
                      Divider(
                        height: 15,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
