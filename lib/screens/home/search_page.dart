import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sliate/screens/widgets/tab-bar.dart';

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
    QuerySnapshot querySnapshot =
        await _firestore.collection('sub_title').get();
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
                child:  TextField(
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
              child: Text(
                'LMS Notes',
                style: GoogleFonts.abyssinicaSil(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
            Container(height: 50, child: const tab_bar()),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: _refreshNotes,
                      child: StreamBuilder<QuerySnapshot>(
                          stream:
                              _firestore.collection('sub_title').snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            Subjects = snapshot.data!.docs;

                            return ListView.builder(
                              itemCount: _getFilteredNotes().length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot note =
                                    _getFilteredNotes()[index];
                                return Column(
                                  children: [
                                    ListTile(
                                      contentPadding: const EdgeInsets.all(5),
                                      title: Text(
                                        note['title'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      tileColor: Colors.white,
                                      selectedColor: Colors.grey,
                                      leading: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Image.asset(
                                          'assets/images/logo/manas.jpg',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      subtitle: const Text("Hi am Manas"),
                                      trailing: const Text("2nd"),
                                    ),
                                    const Divider(
                                      height: 5.0,
                                      color: Colors.transparent,
                                    ),
                                  ],
                                );
                              },
                            );
                          })),
            ),
          ],
        ),
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