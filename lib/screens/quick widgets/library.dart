import 'package:cached_network_image/cached_network_image.dart';
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
    'Personal Computer Applications',
    'Computer Hardware',
    'Structured Programming',
    'Data Representation and Organization',
    'Web Development',
    'Database Management Systems',
    'Mathematics for Computing',
    'English for Technology I',
    'English for Technology II',
    'English for Technology III',
    'English for Technology IV',
    'Object Oriented Programming',
    'Graphics and Multimedia',
    'Data Structures and Algorithms',
    'Systems Analysis and Design',
    'Data Communications and Networks I',
    'Data Communications and Networks II',
    'Statistics for IT',
    'Operating Systems and Computer Security',
    'Project Management',
    'Principles of Management and Applied Economics',
    'Mini Project',
    'Rapid Application Development',
    'Principals of Software Engineering',
    'Object Oriented Analysis and Design',
    'Advance Database Management Systems',
    'Enterprise Information Security Systems',
    'Computer Architecture',
    'Free and Open Source Systems',
    'Project',
  ];
  List<String> filteredSubjects = [];
  List<String> favoriteSubjects = [];

  bool get isSearching => _textcontroller.text.isNotEmpty;

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
          color: Colors.black,
        ),
      ),
      body: Column(
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
                Container(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  child: Column(
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
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
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
              ],
            ),
          ),
          const SizedBox(
            height: 20,
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
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount:
                  isSearching ? filteredSubjects.length : subjects.length,
              itemBuilder: (context, index) {
                final subject =
                    isSearching ? filteredSubjects[index] : subjects[index];
                return ListTile(
                  title: Text(
                    subject,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'Source : SLIATE Library',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  leading: Image.network(
                    'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fstatic.vecteezy.com%2Fsystem%2Fresources%2Fpreviews%2F000%2F357%2F095%2Foriginal%2Fvector-book-icon.jpg&f=1&nofb=1&ipt=769557ffdc66fcdff0d5a3dc71cfd382ac96adccee1d2a8553f071ec8ec512ff&ipo=images',
                  ),
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
              'Showing ${isSearching ? filteredSubjects.length : subjects.length} out of ${subjects.length} items',
              style: GoogleFonts.mavenPro(
                textStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.red,
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
    );
  }
}
