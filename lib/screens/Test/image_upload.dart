import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class NewsFeedPage extends StatefulWidget {
  @override
  _NewsFeedPageState createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  bool _isImageSelected = false;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _isImageSelected = true;
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadImageToFirebase() async {
    if (_image == null) {
      return;
    }

    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = storage.ref().child('news_feed/$fileName');
      UploadTask uploadTask = ref.putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      saveDataToFirestore(imageUrl);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image uploaded successfully!')),
      );
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
    }
  }

  Future<void> saveDataToFirestore(String imageUrl) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore.collection('news').add({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'imageUrl': imageUrl,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Feed'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: getImage,
              style: ElevatedButton.styleFrom(
                primary: _isImageSelected ? Colors.green : null,
              ),
              child: Text(
                _isImageSelected ? 'Pick a Image' : 'Uploaded',
                style: TextStyle(
                  color: _isImageSelected ? Colors.black : null,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            _image != null
                ? Image.file(
                    _image!,
                    height: 200.0,
                  )
                : Placeholder(fallbackHeight: 200.0),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: uploadImageToFirebase,
              child: Text('Save Data'),
            ),
          ],
        ),
      ),
    );
  }
}
