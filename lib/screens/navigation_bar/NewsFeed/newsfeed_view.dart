import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class newsfeed_view extends StatelessWidget {
  final String description;
  final String urlToImage;

  const newsfeed_view(
      {super.key, required this.description, required this.urlToImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change the color of the back arrow here
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Add your action code here
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              // Add your action code here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Column(
            children: [
              // TextField(
              //   controller: _paragraphController,
              //   decoration: InputDecoration(
              //     labelText: 'Enter Paragraph',
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // ElevatedButton(
              //   onPressed: saveParagraph,
              //   child: Text('Save Paragraph'),
              // ),
              const ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/logo/manas.jpg',
                  ),
                ),
                title: Text(
                  'Manas Afrid',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '12 min ago',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      urlToImage,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
