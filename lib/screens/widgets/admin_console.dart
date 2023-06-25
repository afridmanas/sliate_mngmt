import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';

class AdminConsole extends StatefulWidget {
  const AdminConsole({Key? key}) : super(key: key);

  @override
  State<AdminConsole> createState() => _AdminConsoleState();
}

class _AdminConsoleState extends State<AdminConsole> {
  bool _isExpanded = false;
  final TextEditingController _staffNameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg_clr,
      appBar: AppBar(
        backgroundColor: bg_clr,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'Admin Panel',
                style: GoogleFonts.mavenPro(
                  textStyle: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      letterSpacing: .5),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10, // Replace with your desired item count
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => admin_control(),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class admin_control extends StatefulWidget {
  const admin_control({super.key});

  @override
  State<admin_control> createState() => _admin_controlState();
}

class _admin_controlState extends State<admin_control> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            color: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: Container(
              height: height / 1.5,
              width: width / 1.2,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
