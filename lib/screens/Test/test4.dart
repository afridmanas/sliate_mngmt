import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class update_function extends StatefulWidget {
  @override
  _update_functionState createState() => _update_functionState();
}

class _update_functionState extends State<update_function> {
  String selectedAction = 'Insert';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void performAction() async {
    switch (selectedAction) {
      case 'Insert':
        await insertData();
        break;
      case 'Update':
        await updateData();
        break;
      case 'Delete':
        await deleteData();
        break;
    }
  }

  Future<void> insertData() async {
    try {
      await firestore.collection('myCollection').add({
        'field1': 'value1',
        'field2': 'value2',
      });
      print('Data inserted successfully');
    } catch (e) {
      print('Error inserting data: $e');
    }
  }

  Future<void> updateData() async {
    try {
      await firestore.collection('myCollection').doc('documentId').update({
        'field1': 'updatedValue1',
        'field2': 'updatedValue2',
      });
      print('Data updated successfully');
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  Future<void> deleteData() async {
    try {
      await firestore.collection('myCollection').doc('documentId').delete();
      print('Data deleted successfully');
    } catch (e) {
      print('Error deleting data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedAction,
              onChanged: (String? newValue) {
                setState(() {
                  selectedAction = newValue!;
                });
              },
              items: <String>['Insert', 'Update', 'Delete']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: performAction,
              child: Text('Perform Action'),
            ),
          ],
        ),
      ),
    );
  }
}
