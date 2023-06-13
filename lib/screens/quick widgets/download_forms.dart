import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/screens/quick%20widgets/doc_view.dart';
import 'package:sliate/screens/widgets/dox_file.dart';

class DownloadForms extends StatefulWidget {
  const DownloadForms({Key? key}) : super(key: key);

  @override
  _DownloadFormsState createState() => _DownloadFormsState();
}

class _DownloadFormsState extends State<DownloadForms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change the color of the back arrow here
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            size: 23,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(
              CupertinoIcons.search,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Documents',
                  style: GoogleFonts.mavenPro(
                    textStyle: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      letterSpacing: .5,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Dashboard > Documents',
                    style: GoogleFonts.mavenPro(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5,
                ),
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const doc_view()),
                        ),
                      );
                    },
                    child: const doc_file(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
