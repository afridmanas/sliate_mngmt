import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseImagePage extends StatefulWidget {
  final String imageUrl;

  const FirebaseImagePage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _FirebaseImagePageState createState() => _FirebaseImagePageState();
}

class _FirebaseImagePageState extends State<FirebaseImagePage> {
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _downloadImage();
  }

  Future<void> _downloadImage() async {
    final ref = FirebaseStorage.instance.ref().child(widget.imageUrl);
    final bytes = await ref.getData();
    setState(() {
      _imageFile = File.fromRawPath(bytes!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Image'),
      ),
      body: Center(
        child: _imageFile != null
            ? Image.file(_imageFile!)
            : const CircularProgressIndicator(),
      ),
    );
  }
}
