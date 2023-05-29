import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sliate/screens/categories/course-details.dart';
import 'package:sliate/screens/widgets/tab-bar.dart';

class Notes_Page extends StatefulWidget {
  const Notes_Page({Key? key}) : super(key: key);

  @override
  State<Notes_Page> createState() => _Notes_PageState();
}

class _Notes_PageState extends State<Notes_Page> {
  final TextEditingController _textEditingController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> Subjects = [];
  String _searchText = '';
  bool _isLoading = false;

  void _getNotes() async {
    setState(() {
      _isLoading = true;
    });
    QuerySnapshot querySnapshot =
        await _firestore.collection('sub_title').get();
    setState(
      () {
        Subjects = querySnapshot.docs;
        _isLoading = false;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getNotes();
  }

  List<DocumentSnapshot> _getFilteredNotes() {
    if (_searchText.isEmpty) {
      return Subjects;
    } else {
      return Subjects.where((note) {
        String title = note['title'].toLowerCase();

        String searchText = _searchText.toLowerCase();
        return title.contains(searchText);
      }).toList();
    }
  }

  void _searchNotes(String searchText) {
    setState(() {
      _searchText = searchText;
    });
  }

  Future<void> _refreshNotes() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('sub_title').get();
    setState(() {
      Subjects = querySnapshot.docs;
    });
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300.0,
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Subject Name'),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                    onPressed: () => {
                          _firestore.collection('sub_title').add({
                            'title': _textEditingController.text,
                            'content': 'sub_title',
                          }),
                          _textEditingController.clear()
                        },
                    icon: const Icon(Icons.save),
                    label: const Text('Save')),
              ),
            ],
          )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, // Change the color of the back arrow here
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              // Add your action code here
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Find Your favourite',
                  style: GoogleFonts.mavenPro(
                    textStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  'notes here!',
                  style: GoogleFonts.mavenPro(
                    textStyle: const TextStyle(
                      color: Colors.purple,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) => _searchNotes(value),
              decoration: InputDecoration(
                filled: true,
                fillColor: bg,
                hintText: 'Search Here',
                prefixIcon: const Icon(Icons.search_sharp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: GoogleFonts.mavenPro(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CourseDetails()),
                    );
                  },
                  child: Text(
                    'View All',
                    style: GoogleFonts.mavenPro(
                      textStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 200,
                        width: width / 5 * 2.20,
                        child: Center(child: Text('HNDE')),
                      ),
                      Container(
                        height: 200,
                        width: width / 5 * 2.20,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 21, 7, 83),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(child: Text('HNDIT')),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 200,
                    width: width / 5 * 4.60,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text('HNDA'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheet(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.grey,
        foregroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}



// Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextField(
              //     controller: _textEditingController,
              //     decoration: InputDecoration(
              //       hintText: 'Add a new Subject',
              //     ),
              //   ),
              // ),
              // ElevatedButton(
              //   child: Text('Add'),
              //   onPressed: () {
              //     _firestore.collection('sub_title').add({
              //       'title': _textEditingController.text,
              //       'content': 'sub_title',
              //     });
              //     _textEditingController.clear();
              //   },
              // ),