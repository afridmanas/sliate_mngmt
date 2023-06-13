import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesPage extends StatelessWidget {
  final List<String> favoriteSubjects;

  const FavoritesPage({Key? key, required this.favoriteSubjects})
      : super(key: key);

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
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Favourite Books',
              style: GoogleFonts.mavenPro(
                textStyle: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: favoriteSubjects.length,
                itemBuilder: (context, index) {
                  final subject = favoriteSubjects[index];
                  return ListTile(
                    title: Text(
                      subject,
                      style: const TextStyle(
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
