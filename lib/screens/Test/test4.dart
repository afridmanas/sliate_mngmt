// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class update_function extends StatefulWidget {
//   @override
//   _update_functionState createState() => _update_functionState();
// }

// class _update_functionState extends State<update_function> {
//   String selectedAction = 'Insert';
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   void performAction() async {
//     switch (selectedAction) {
//       case 'Insert':
//         await insertData();
//         break;
//       case 'Update':
//         await updateData();
//         break;
//       case 'Delete':
//         await deleteData();
//         break;
//     }
//   }

//   Future<void> insertData() async {
//     try {
//       await firestore.collection('myCollection').add({
//         'field1': 'value1',
//         'field2': 'value2',
//       });
//       print('Data inserted successfully');
//     } catch (e) {
//       print('Error inserting data: $e');
//     }
//   }

//   Future<void> updateData() async {
//     try {
//       await firestore.collection('myCollection').doc('documentId').update({
//         'field1': 'updatedValue1',
//         'field2': 'updatedValue2',
//       });
//       print('Data updated successfully');
//     } catch (e) {
//       print('Error updating data: $e');
//     }
//   }

//   Future<void> deleteData() async {
//     try {
//       await firestore.collection('myCollection').doc('documentId').delete();
//       print('Data deleted successfully');
//     } catch (e) {
//       print('Error deleting data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             DropdownButton<String>(
//               value: selectedAction,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedAction = newValue!;
//                 });
//               },
//               items: <String>['Insert', 'Update', 'Delete']
//                   .map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: performAction,
//               child: Text('Perform Action'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsFeedPage extends StatefulWidget {
  @override
  _NewsFeedPageState createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  List<NewsItem> newsList = [];

  @override
  void initState() {
    super.initState();
    fetchNewsData();
  }

  Future<void> fetchNewsData() async {
    final response = await http.get(
      Uri.parse(
        'https://raw.githubusercontent.com/afridmanas/sliate_mngmt/manas_project/lib/newsfeed_json.json',
      ),
    );

    if (response.statusCode == 200) {
      try {
        final jsonData = json.decode(response.body);
        final List<dynamic> newsData = jsonData['news'];

        setState(() {
          newsList = newsData.map((data) => NewsItem.fromJson(data)).toList();
        });
      } catch (e) {
        print('Error parsing JSON data: $e');
      }
    } else {
      print('Failed to fetch news data. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SLIATE News Feed'),
      ),
      body: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final newsItem = newsList[index];
          return ListTile(
            //leading: Image.network(newsItem.leading),
            title: Text(newsItem.title),
            subtitle: Text(newsItem.subtitle),
            trailing: Text(newsItem.date),
          );
        },
      ),
    );
  }
}

class NewsItem {
  final String title;
  final String subtitle;
  //final String leading;
  final String date;
  final String department;

  NewsItem({
    required this.title,
    required this.subtitle,
    // required this.leading,
    required this.date,
    required this.department,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      // leading: json['leading'] ?? '',
      date: json['date'] ?? '',
      department: json['department'] ?? '',
    );
  }
}
