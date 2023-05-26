import 'package:flutter/material.dart';
import 'package:sliate/color.dart';

class dropmenu extends StatefulWidget {
  @override
  _dropmenuState createState() => _dropmenuState();
}

class _dropmenuState extends State<dropmenu> {
  bool? _checkvalue = false;

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: secondary,
          ),
          height: 380.0,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                // Container(
                //   height: 75,
                //   width: 75,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15),
                //     // color: secondary,
                //     image: const DecorationImage(
                //       image: AssetImage(
                //         'assets/images/logo/manas.jpg',
                //       ),
                //       fit: BoxFit.fill,
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 14,right: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.nightlight,color: Colors.grey,),
                           SizedBox(
                            width: 32,
                          ),
                          Text('Dark Mode'),
                        ],
                      ), 
                      Switch(
                        onChanged: (t) {
                          setState(() {
                            _checkvalue = t;
                          });
                        },
                        value: _checkvalue!,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Notification'),
                 trailing: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 30,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Account Preferences'),
                  trailing: Icon(Icons.keyboard_arrow_right_outlined,size: 30,),
                ),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Invite a friend'),
                trailing: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 30,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.call),
                  title: Text('Contact us'),
                trailing: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 30,
                  ),
                ),
                 ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Sign Out'),
                trailing: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 30,
                  ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.grey),
      ),
      icon: Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.settings,
                color: Colors.black,
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text('Settings'),
                ),
                onTap: () => {_showBottomSheet(context)},
              )
            ],
          ),
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.settings,
                color: Colors.black,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text('About'),
              )
            ],
          ),
          onTap: () => {
            print('Tab Settings'),
          },
        ),
      ],
    );
  }
}
