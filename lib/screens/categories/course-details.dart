import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({Key? key}) : super(key: key);

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  final TextEditingController _textEditingController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> Subjects = [];
  String _searchText = '';

  void _getNotes() async {
    setState(() {});
    QuerySnapshot querySnapshot =
        await _firestore.collection('sub_title').get();
    setState(
      () {
        Subjects = querySnapshot.docs;
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
        return SizedBox(
          height: 300.0,
          child: Center(
              child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change the color of the back arrow here
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // Add your action code here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: RefreshIndicator(
          onRefresh: _refreshNotes,
          child: Column(
            children: [
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
              const SizedBox(
                height: 5,
              ),
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
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('sub_title').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    Subjects = snapshot.data!.docs;

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.95,
                      ),
                      itemCount: Subjects.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot note = _getFilteredNotes()[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 150,
                            width: double.infinity / 5 * 2.20,
                            child: Center(child: Text(note['title'])),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheet(context);
        },
        backgroundColor: Colors.grey,
        foregroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}


// ListView.builder(
//                         itemCount: _getFilteredNotes().length,
//                         itemBuilder: (context, index) {
//                           DocumentSnapshot note = _getFilteredNotes()[index];
//                           return Column(
//                             children: [
//                               ListTile(
//                                 contentPadding: const EdgeInsets.all(5),
//                                 title: Text(
//                                   note['title'],
//                                   style: const TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 tileColor: Colors.white,
//                                 selectedColor: Colors.grey,
//                                 leading: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(50.0),
//                                   ),
//                                   child: Image.asset(
//                                     'assets/images/logo/manas.jpg',
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 subtitle: const Text("Hi am Manas"),
//                                 trailing: const Text("2nd"),
//                               ),
//                               const Divider(
//                                 height: 5.0,
//                                 color: Colors.transparent,
//                               ),
//                             ],
//                           );
//                         },
//                       );
                   