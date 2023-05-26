import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class notes_taking extends StatefulWidget {
  @override
  _notes_takingState createState() => _notes_takingState();
}

class _notes_takingState extends State<notes_taking> {
  final TextEditingController _textEditingController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('notes').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot note = snapshot.data!.docs[index];
                    return ListTile(
                      title: Text(note['title']),
                      subtitle: Text(note['content']),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Add a new note',
              ),
            ),
          ),
          ElevatedButton(
            child: Text('Add'),
            onPressed: () {
              _firestore.collection('notes').add({
                'title': 'New Note',
                'content': _textEditingController.text,
              });
              _textEditingController.clear();
            },
          ),
        ],
      ),
    );
  }
}
