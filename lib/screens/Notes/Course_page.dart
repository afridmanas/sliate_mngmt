import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CourseDetailsPage extends StatefulWidget {
  const CourseDetailsPage({super.key});

  @override
  _CourseDetailsPageState createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  File? _imageFile;

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

    await _db.collection('courses').add({
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

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change the color of the back arrow here
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
               PopupMenuItem(
                value: 'add',
                child: Text('Add Course Details'),
              ),
            ],
            onSelected: (value) {
              if (value == 'add') {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Add Course Details',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextField(
                              controller: _titleController,
                              decoration: const InputDecoration(
                                labelText: 'Title',
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextField(
                              controller: _yearController,
                              decoration: const InputDecoration(
                                labelText: 'Year',
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextField(
                              controller: _semesterController,
                              decoration: const InputDecoration(
                                labelText: 'Semester',
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextField(
                              controller: _departmentController,
                              decoration: const InputDecoration(
                                labelText: 'Department',
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        _pickImage(ImageSource.camera),
                                    child: const Text('Take a Photo'),
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        _pickImage(ImageSource.gallery),
                                    child: const Text('Choose from Gallery'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: _addCourseDetails,
                              child: const Text('Add'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection('courses').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //   crossAxisCount: 2,
            //   childAspectRatio: 0.75,
            // ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var course = snapshot.data!.docs[index];
              // DocumentSnapshot courseId = snapshot.data!.docs[index];

              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: course['image'] != null
                          ? Image.network(
                              course['image'],
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.image),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        course['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Year: ${course['year']}',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Semester: ${course['semester']}',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Department: ${course['department']}',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () => {},
                          // _showUpdateCourseDetails(
                          //courseId  ,
                          // course['title'],
                          // course['year'],
                          // course['semester'],
                          // course['department'],
                          // course['image'],

                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () => {},
                          //   _showDeleteCourseDetails(courseId),
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
