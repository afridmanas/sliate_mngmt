import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliate/color.dart';

class Notes_home extends StatefulWidget {
  const Notes_home({Key? key}) : super(key: key);

  @override
  State<Notes_home> createState() => _Notes_homeState();
}

class _Notes_homeState extends State<Notes_home>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _tabcontroller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabcontroller.dispose();
    super.dispose();
  }

  void _addCourseDetails() async {
    String? imageUrl;

    if (_imageFile != null) {
      // Upload image to Firebase Storage
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('course_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final UploadTask uploadTask = storageReference.putFile(_imageFile!);
      final TaskSnapshot downloadUrl = (await uploadTask);
      imageUrl = (await downloadUrl.ref.getDownloadURL());
    }

    await _db.collection('/lms/departments/hndit/semester1/sub_1').add({
      'title': _titleController.text,
      'year': _yearController.text,
      'semester': _semesterController.text,
      'department': _departmentController.text,
      'image': imageUrl,
    });

    _titleController.clear();
    _yearController.clear();
    _semesterController.clear();
    _departmentController.clear();
    setState(() {
      _imageFile = null;
    });

    Navigator.pop(context);
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(
      () {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        } else {
          if (kDebugMode) {
            print('No image selected.');
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Container(
                      height: 200,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/bg/bg2.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: 420,
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Academic Notes',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      indicator:
                          DotTabIndicator(color: Colors.black, radius: 4),
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      controller: _tabcontroller,
                      tabs: const [
                        Tab(
                          text: 'Semester 1',
                        ),
                        Tab(
                          text: 'Semester 1',
                        ),
                        Tab(
                          text: 'Semester 1',
                        ),
                        Tab(
                          text: 'Semester 4',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabcontroller,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: _db
                              .collection(
                                  '/lms/departments/hndit/semester1/sub_1')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return ListView.builder(
                              itemBuilder: (context, index) {
                                var course = snapshot.data!.docs[index];
                                return GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: ((context) => NotesPatPaper(
                                    //           title: course['title'],
                                    //         )),
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(right: 15),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    height: 80,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: bg_clr,
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: bg_clr,
                                            ),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                course['image'],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                course['title'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '${course['year']} Year '
                                                '${course['semester']} Semester',
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: snapshot.data!.docs.length,
                            );
                          },
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: _db
                              .collection(
                                  '/lms/departments/hndit/semester2/sub_1')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return ListView.builder(
                              itemBuilder: (context, index) {
                                var course = snapshot.data!.docs[index];
                                return GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: ((context) => NotesPatPaper(
                                    //         title: course['title'])),
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(right: 15),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    height: 80,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: bg_clr,
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: bg_clr,
                                            ),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                course['image'],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                course['title'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '${course['year']} Year '
                                                '${course['semester']} Semester',
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: snapshot.data!.docs.length,
                            );
                          },
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: _db
                              .collection(
                                  '/lms/departments/hndit/semester3/sub_1')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return ListView.builder(
                              itemBuilder: (context, index) {
                                var course = snapshot.data!.docs[index];
                                return GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: ((context) => NotesPatPaper(
                                    //         title: course['title'])),
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(right: 15),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    height: 80,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: bg_clr,
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: bg_clr,
                                            ),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                course['image'],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                course['title'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '${course['year']} Year '
                                                '${course['semester']} Semester',
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: snapshot.data!.docs.length,
                            );
                          },
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: _db
                              .collection(
                                  '/lms/departments/hndit/semester3/sub_1')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return ListView.builder(
                              itemBuilder: (context, index) {
                                var course = snapshot.data!.docs[index];
                                return GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: ((context) => NotesPatPaper(
                                    //         title: course['title'])),
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(right: 15),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    height: 80,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: bg_clr,
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: bg_clr,
                                            ),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                course['image'],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                course['title'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '${course['year']} Year '
                                                '${course['semester']} Semester',
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: snapshot.data!.docs.length,
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DotTabIndicator extends Decoration {
  final BoxPainter _painter;

  DotTabIndicator({required Color color, required double radius})
      : _painter = _DotPainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _DotPainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _DotPainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final center = offset +
        Offset(configuration.size!.width / 2,
            configuration.size!.height - radius - 2);
    canvas.drawCircle(center, radius, _paint);
  }
}
