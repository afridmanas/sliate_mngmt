import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class search_page extends StatefulWidget {
  const search_page({Key? key}) : super(key: key);

  @override
  State<search_page> createState() => _search_pageState();
}

class _search_pageState extends State<search_page> {
  final TextEditingController _textEditingController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> Subjects = [];
  String _searchText = '';
  bool _isLoading = false;

  void _getNotes() async {
    setState(() {
      _isLoading = true;
    });
    QuerySnapshot querySnapshot = await _firestore.collection('sub_title').get();
    setState(() {
      Subjects = querySnapshot.docs;
       _isLoading = false;
    });
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
    QuerySnapshot querySnapshot = await _firestore.collection('sub_title').get();
    setState(() {
      Subjects = querySnapshot.docs;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search for LMS Notes',
              style: GoogleFonts.mavenPro(
                textStyle: const TextStyle(
                  color: text,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
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
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: _refreshNotes,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _firestore.collection('sub_title').snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          Subjects = snapshot.data!.docs;

                          return ListView.builder(
                itemCount: _getFilteredNotes().length,
                itemBuilder: (context, index) {
                  DocumentSnapshot note = _getFilteredNotes()[index];
                  return ListTile(
                    contentPadding: EdgeInsets.all(5),
                    title: Text(
                      note['title'],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              );
  }))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Add a new Subject',
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                _firestore.collection('sub_title').add({
                  'title': _textEditingController.text,
                  'content': 'sub_title',
                });
                _textEditingController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
