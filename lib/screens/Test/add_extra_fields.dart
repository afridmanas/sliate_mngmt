import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreExamplePage extends StatefulWidget {
  @override
  _FirestoreExamplePageState createState() => _FirestoreExamplePageState();
}

class _FirestoreExamplePageState extends State<FirestoreExamplePage> {
  

 void addExtraFieldsToDocuments() async {
    // Reference to the Firestore collection
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('/lms/departments/hndit/semester3/subject_list');

    // Get the documents in the collection
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Iterate through each document and update the fields
    querySnapshot.docs.forEach((doc) async {
      // Update the document with the new fields
      await doc.reference.update({
        'notes_path':
            '/Academic Modules/HNDIT/Semester 1/Computer Hardware/Past Paper', // Replace 'path_to_notes' with the actual path for notes
        'past_path':
            '/Academic Modules/HNDIT/Semester 1/Computer Hardware/Past Paper', // Replace 'path_to_pastpapers' with the actual path for past papers
      });
    });

    print('Extra fields added to documents successfully.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: addExtraFieldsToDocuments,
          child: Text('Add Extra Fields to Documents'),
        ),
      ),
    );
  }
}


// Future<void> insertData() async {
  //   try {
  //     QuerySnapshot querySnapshot = await _collectionRef.get();

  //     querySnapshot.docs
  //         .asMap()
  //         .forEach((index, DocumentSnapshot documentSnapshot) async {
  //       String documentId = documentSnapshot.id;

  //       // Insert values for already added fields
  //       await _collectionRef.doc(documentId).update({
  //         'duration': durationList[index],
  //       });
  //     });

  //     print('Data inserted successfully');
  //   } catch (e) {
  //     print('Error inserting data: $e');
  //   }
  // }