import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/screens/widgets/favourites.dart';

class library_page extends StatefulWidget {
  const library_page({Key? key}) : super(key: key);

  @override
  _library_pageState createState() => _library_pageState();
}

class _library_pageState extends State<library_page> {
  TextEditingController _textcontroller = TextEditingController();
  List<String> subjects = [
    'Mathematics',
    'Physics',
    'Chemistry',
    'Biology',
    'History',
    'Geography',
    'English',
    'Computer Science',
    'Art',
    'Music',
  ];
  List<String> filteredSubjects = [];
  List<String> favoriteSubjects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesPage(
                    favoriteSubjects: favoriteSubjects,
                  ),
                ),
              );
            },
          ),
        ],
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
            Container(
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Library',
                        style: GoogleFonts.mavenPro(
                          textStyle: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              letterSpacing: .5),
                        ),
                      ),
                      Text(
                        'Find your favourite book',
                        style: GoogleFonts.mavenPro(
                          textStyle: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              letterSpacing: .5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.7),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _textcontroller,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              hintText: 'Ex: Data Structure',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.7),
                              ),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  if (value.isNotEmpty) {
                                    filteredSubjects = subjects
                                        .where((subject) => subject
                                            .toLowerCase()
                                            .contains(value.toLowerCase()))
                                        .toList();
                                  } else {
                                    filteredSubjects = [];
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Card(
                        child: IconButton(
                          icon: const Icon(
                            CupertinoIcons.command,
                            size: 35,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  //   Container(
                  //     height: 50,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(8),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey.withOpacity(0.3),
                  //           blurRadius: 3,
                  //           offset: Offset(0, 2),
                  //         ),
                  //       ],
                  //     ),
                  //     child: TextField(
                  //       controller: _textcontroller,
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         color: Colors.black,
                  //       ),
                  //       decoration: InputDecoration(
                  //         contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  //         hintText: 'Ex: Data Structure and Algorithms',
                  //         hintStyle: TextStyle(
                  //           fontSize: 16,
                  //           color: Colors.grey.withOpacity(0.7),
                  //         ),
                  //         border: InputBorder.none,
                  //       ),
                  //     ),
                  //   ),
                  // ],
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
              ),
              child: Text(
                'Available Books',
                style: GoogleFonts.mavenPro(
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: .5),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSubjects.length,
                itemBuilder: (context, index) {
                  final subject = filteredSubjects[index];
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
                    trailing: IconButton(
                      icon: Icon(
                        favoriteSubjects.contains(subject)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: favoriteSubjects.contains(subject)
                            ? Colors.red
                            : Colors.grey,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            if (favoriteSubjects.contains(subject)) {
                              favoriteSubjects.remove(subject);
                            } else {
                              favoriteSubjects.add(subject);
                            }
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Center(
              child: Text(
                'Showing ${filteredSubjects.length} out of ${subjects.length} items',
                style: GoogleFonts.mavenPro(
                  textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .5),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
