import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class doc_view extends StatefulWidget {
  const doc_view({Key? key}) : super(key: key);

  @override
  _doc_viewState createState() => _doc_viewState();
}

class _doc_viewState extends State<doc_view> {
  List<bool> isPressedList = List.filled(6, false);

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
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Exam Applications',
                    style: GoogleFonts.mavenPro(
                      textStyle: const TextStyle(
                        fontSize: 32,
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
                      'Dashboard > Documents > Exam Applications',
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
            ),
            const SizedBox(
              height: 60,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: const Text(
                    'Examination',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'Author: Manas Afrid',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  leading: Image.asset('assets/images/logo/manas.jpg'),
                  trailing: TrailingIcon(
                    isPressed: isPressedList[index],
                    onPressed: () {
                      setState(() {
                        isPressedList[index] = !isPressedList[index];
                      });
                    },
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}

class TrailingIcon extends StatelessWidget {
  final bool isPressed;
  final VoidCallback onPressed;

  const TrailingIcon({
    super.key,
    required this.isPressed,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isPressed ? Icons.download_done : Icons.download,
        color: Colors.grey,
      ),
      onPressed: onPressed,
    );
  }
}
