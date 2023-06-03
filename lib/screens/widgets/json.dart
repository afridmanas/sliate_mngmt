import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sliate/color.dart';

class json extends StatelessWidget {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Add Multiple Data Example'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Add Multiple Data'),
          onPressed: () {
            addMultipleData();
          },
        ),
      ),
    );
  }

  void addMultipleData() async {
    CollectionReference codingSegmentsCollection =
        _db.collection('/lms/departments/hndit/semester3/sub_1');

    List<Map<String, dynamic>> dataList = [];

    List<String> textList = [
      'Operating Systems and Computer Security',
      'Project Management',
      'Principles of Management and Applied Economics',
      'Mini Project',
      'Principals of Software Engineering',
      'Rapid Application Development',
      'English for Technology III',
      'Object Oriented Analysis and Design',
      'Advance Database Management Systems',
      'Data Communications and Networks II',
      'Enterprise Information Security Systems',
    ];

    for (int i = 0; i < textList.length; i++) {
      Map<String, dynamic> newData = {
        'title': textList[i],
        'year': '2nd',
        'semester': '1st',
        'department': 'HNDIT',
        'image':
            'https://firebasestorage.googleapis.com/v0/b/sliate-sam.appspot.com/o/course_images%2F1685345014946.jpg?alt=media&token=035d04ba-6abf-4126-a349-bb6cb25b164b'
      };

      await codingSegmentsCollection.add(newData);
    }
  }
}
