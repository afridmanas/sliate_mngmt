import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CourseDisplayPage extends StatefulWidget {
  @override
  _CourseDisplayPageState createState() => _CourseDisplayPageState();
}

class _CourseDisplayPageState extends State<CourseDisplayPage> {
  List<Course> courses = [];
  String selectedCourseId = '';

  Future<void> fetchCourses() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/USERNAME/REPO/main/courses.json'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        courses =
            data.map((courseData) => Course.fromJson(courseData)).toList();
      });
    } else {
      throw Exception('Failed to fetch courses');
    }
  }

  void updateCourseData(String coursePeriod, String lectureName) async {
    final selectedCourseIndex =
        courses.indexWhere((course) => course.id == selectedCourseId);
    if (selectedCourseIndex >= 0) {
      setState(() {
        courses[selectedCourseIndex].coursePeriod = coursePeriod;
        courses[selectedCourseIndex].lectureName = lectureName;
      });
    }

    final updatedData = courses.map((course) => course.toJson()).toList();
    final updatedDataString = jsonEncode(updatedData);

    final response = await http.put(
      Uri.parse(
          'https://github.com/afridmanas/sliate_mngmt/blob/manas_project/lib/newsfeed_json.json'),
      headers: {
        'Authorization': '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',
      },
      body: jsonEncode({
        'message': 'Update course data',
        'content': base64Encode(utf8.encode(updatedDataString)),
        'sha': 'SHA_OF_THE_CURRENT_FILE',
      }),
    );

    if (response.statusCode == 200) {
      // File updated successfully
      print('Course data updated');
    } else {
      // Handle error
      print('Failed to update course data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Display'),
      ),
      body: Column(
        children: [
          DropdownButtonFormField<String>(
            value: selectedCourseId,
            onChanged: (value) {
              setState(() {
                selectedCourseId = value!;
              });
            },
            items: courses.map<DropdownMenuItem<String>>((Course course) {
              return DropdownMenuItem<String>(
                value: course.id,
                child: Text(course.title),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Select Course',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return ListTile(
                  title: Text(course.title),
                  subtitle: Text(course.description),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: 'Course Period'),
                        onChanged: (value) {
                          setState(() {
                            course.coursePeriod = value;
                          });
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Lecture Name'),
                        onChanged: (value) {
                          setState(() {
                            course.lectureName = value;
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final selectedCourse =
                  courses.firstWhere((course) => course.id == selectedCourseId);
              updateCourseData(
                  selectedCourse.coursePeriod, selectedCourse.lectureName);
            },
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}

class Course {
  final String id;
  final String title;
  final String description;
  String coursePeriod;
  String lectureName;

  Course({
    required this.id,
    required this.title,
    required this.description,
    this.coursePeriod = '',
    this.lectureName = '',
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'coursePeriod': coursePeriod,
      'lectureName': lectureName,
    };
  }
}
