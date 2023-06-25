import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';
import 'package:sliate/screens/error_page.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String department = '';

  void addTask() async {
    CollectionReference staffsCollection =
        FirebaseFirestore.instance.collection('tasks');

    QuerySnapshot snapshot = await staffsCollection.get();
    int taskcount = snapshot.size + 1;

    String taskId = 'Task ${taskcount.toString().padLeft(2, '0')}';
    if (_taskController.text.isNotEmpty) {
      Task newTask = Task(
        title: _taskController.text,
        description: _descriptionController.text,
        id: taskId,
        department: department.toLowerCase(),
      );
      FirebaseFirestore.instance.collection('tasks').add({
        'title': newTask.title,
        'description': newTask.description,
        'id': newTask.id,
        'department': newTask.department.toLowerCase(),
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('New Task Added Successfully')),
        );
        Navigator.pop(context, newTask);
      }).catchError((error) {
        ErrorHandling.navigateToErrorScreen();
      });
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Text(
                'New Task',
                style: GoogleFonts.mavenPro(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5,
                    inherit: true,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _taskController,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: 'Add a New Task',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _descriptionController,
                maxLines: 3,
                // expands: true,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
              ),
            ),
            RadioListTile(
              value: 'HNDIT',
              groupValue: department,
              onChanged: (value) {
                setState(() {
                  department = value!;
                });
              },
              title: Text('HNDIT'),
            ),
            RadioListTile(
              value: 'HNDE',
              groupValue: department,
              onChanged: (value) {
                setState(() {
                  department = value!;
                });
              },
              title: Text('HNDE'),
            ),
            RadioListTile(
              value: 'HNDA',
              groupValue: department,
              onChanged: (value) {
                setState(() {
                  department = value!;
                });
              },
              title: Text('HNDA'),
            ),
            Center(
              child: ElevatedButton(
                onPressed: addTask,
                child: const Text('Add Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  final String title;
  final String description;
  final String department;
  final String id;

  Task({
    required this.title,
    required this.description,
    required this.department,
    required this.id,
  });
}
