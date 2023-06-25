import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:sliate/color.dart';
import 'package:sliate/screens/error_page.dart';

class Newsfeed_Add extends StatefulWidget {
  @override
  _Newsfeed_AddState createState() => _Newsfeed_AddState();
}

class _Newsfeed_AddState extends State<Newsfeed_Add> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isImageSelected = false;
  File? _image;
  final picker = ImagePicker();
  bool _uploadingData = false;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _isImageSelected = true;
      } else {
        SnackBar(
          content: Text('No image selected'),
        );
      }
    });
  }

  Future<void> uploadImageToFirebase() async {
    if (_image == null) {
      return;
    }

    setState(() {
      _uploadingData = true;
    });

    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = storage.ref().child('news_feed/$fileName');
      UploadTask uploadTask = ref.putFile(_image!);

      TaskSnapshot taskSnapshot = await uploadTask;

      String bannerImage = await taskSnapshot.ref.getDownloadURL();

      saveDataToFirestore(bannerImage);

      setState(() {
        _uploadingData = false;
      });
    } catch (e) {
      ErrorHandling.navigateToErrorScreen();
      setState(() {
        _uploadingData = false;
      });
    }
  }

  Future<void> saveDataToFirestore(String bannerImage) async {
    DateTime currentDate = DateTime.now();
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();
    String date = DateFormat('yyyy-MM-dd').format(currentDate);

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore.collection('news_feed').add({
        'title': title,
        'description': description,
        'date': date,
        'banner_image': bannerImage,
      });

      setState(() {
        _titleController.clear();
        _descriptionController.clear();
        _image = null;
        _isImageSelected = false;
      });

      print('Data saved to Firestore successfully!');
    } catch (e) {
      print('Error saving data to Firestore: $e');
    }
  }

  Future<void> deleteDataFromFirestore(String documentId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore.collection('news_feed').doc(documentId).delete();

      print('Data deleted from Firestore successfully!');
    } catch (e) {
      print('Error deleting data from Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg_clr,
      appBar: AppBar(
        backgroundColor: bg_clr,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'News Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Image : ',
                    ),
                    Text(
                      _isImageSelected ? 'Image Selected ' : ' Upload a Image',
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: getImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isImageSelected ? Colors.green : null,
                  ),
                  child:
                      _isImageSelected ? Icon(Icons.done) : Icon(Icons.remove),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: uploadImageToFirebase,
              child: _uploadingData
                  ? const CircularProgressIndicator()
                  : const Text('Add Data'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Added Data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('news_feed')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  List<DocumentSnapshot> documents = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      String documentId = documents[index].id;
                      String title = documents[index].get('title') ?? '';

                      return ListTile(
                        title: Text(title),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Data'),
                                content: const Text(
                                    'Are you sure you want to delete this data?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      deleteDataFromFirestore(documentId);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                          },
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
    );
  }
}
