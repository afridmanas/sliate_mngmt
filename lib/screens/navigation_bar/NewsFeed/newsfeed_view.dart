import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class newsfeed_view extends StatefulWidget {
  const newsfeed_view({super.key});

  @override
  State<newsfeed_view> createState() => _newsfeed_viewState();
}

class _newsfeed_viewState extends State<newsfeed_view> {
  String paragraph = '';
  TextEditingController _paragraphController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchParagraph();
  }

  Future<void> fetchParagraph() async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference collection =
          FirebaseFirestore.instance.collection('paragraphs');

      // Get the document snapshot containing the paragraph
      DocumentSnapshot snapshot = await collection
          .doc('documentId')
          .get(); // Replace 'documentId' with the actual document ID

      // Get the paragraph data from the snapshot
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        setState(() {
          paragraph = data['text'];
        });
      }
    } catch (error) {
      print('Failed to fetch paragraph. Error: $error');
    }
  }

  Future<void> saveParagraph() async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference collection =
          FirebaseFirestore.instance.collection('paragraphs');

      // Save the paragraph to Firestore
      await collection.doc('documentId').set({
        'text': _paragraphController.text
      }); // Replace 'documentId' with the actual document ID

      setState(() {
        paragraph = _paragraphController.text;
      });

      // Clear the text field
      _paragraphController.clear();
    } catch (error) {
      print('Failed to save paragraph. Error: $error');
    }
  }

  @override
  void dispose() {
    _paragraphController.dispose();
    super.dispose();
  }

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
              Container(
                height: 300,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/logo/manas.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    paragraph,
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
