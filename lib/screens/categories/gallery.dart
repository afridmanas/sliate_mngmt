import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CourseDetailsPage extends StatefulWidget {
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
        print('No image selected.');
      }
    });
  }

  void _showUpdateCourseDetails(String courseId, String title, String year,
      String semester, String department, String imageUrl) {
    _titleController.text = title;
    _yearController.text = year;
    _semesterController.text = semester;
    _departmentController.text = department;
    setState(() {
      _imageFile = null;
    });

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
                  'Update Course Details',
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
                        onPressed: () => _pickImage(ImageSource.camera),
                        child: const Text('Take a Photo'),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _pickImage(ImageSource.gallery),
                        child: const Text('Choose from Gallery'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    String newImageUrl = imageUrl;

                    if (_imageFile != null) {
                      // Upload new image to Firebase Storage
                      final Reference storageReference =
                          FirebaseStorage.instance.ref().child(
                              'course_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
                      final UploadTask uploadTask =
                          storageReference.putFile(_imageFile!);
                      final TaskSnapshot downloadUrl = (await uploadTask);
                      newImageUrl = (await downloadUrl.ref.getDownloadURL());
                    }

                    await _db.collection('courses').doc(courseId).update({
                      'title': _titleController.text,
                      'year': _yearController.text,
                      'semester': _semesterController.text,
                      'department': _departmentController.text,
                      'image': newImageUrl,
                    });

                    _titleController.clear();
                    _yearController.clear();
                    _semesterController.clear();
                    _departmentController.clear();
                    setState(() {
                      _imageFile = null;
                    });

                    Navigator.pop(context);
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteCourseDetails(String courseId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Course Details'),
          content: const Text('Are you sure you want to delete this course?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _db.collection('courses').doc(courseId).delete();
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, // Change the color of the back arrow here
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
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

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var course = snapshot.data!.docs[index];
              var courseId = snapshot.data!.docs[index];
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
