import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class newsfeed_view extends StatelessWidget {
  // final String description;
  // final String urlToImage;

  const newsfeed_view({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String paragraph =
        'Applications are called for Higher National Diploma (HND) programmes conducted by the Sri Lanka Institute of Advanced Technological Education (SLIATE) from those who have successfully completed the G.C.E.(A/L) Examination in 2021 or preceding years. The applying process should be done only via apply.sliate.ac.lk and any other means of applying will not be accepted. Eligible candidates can select HND programmes under two categories that are based on the Z-score and marks of the selection test conducted by SLIATE.';
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
                      'https://tamilguru.lk/wp-content/uploads/2023/05/SLIATE-HND-Courses-Application-Gazette-2022-2023-Intake.jpg',
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
                    'Admission for SLIATE HND Courses 2023',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
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
