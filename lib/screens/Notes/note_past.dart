import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';

class notes_patpaper extends StatefulWidget {
  final String title;

  notes_patpaper({super.key, required this.title});

  @override
  _notes_patpaperState createState() => _notes_patpaperState();
}

class _notes_patpaperState extends State<notes_patpaper> {
// List<String> pdfUrls = [];

//   @override
//   void initState() {
//     super.initState();
//     loadPdfUrls();
//   }

//   void loadPdfUrls() {
//     // Replace 'your-firebase-storage-bucket' with your actual Firebase Storage bucket
//     firebase_storage.FirebaseStorage storage =
//         firebase_storage.FirebaseStorage.instance;
//     firebase_storage.ListResult result = await storage
//         .ref()
//         .child('pdf')
//         .listAll(); // Replace 'pdf' with the actual path to your PDF files in Firebase Storage
//     List<String> urls = [];
//     result.items.forEach((firebase_storage.Reference ref) {
//       urls.add(ref.fullPath);
//     });
//     setState(() {
//       pdfUrls = urls;
//     });
//   }

//   Future<void> downloadPdf(String url) async {
//     firebase_storage.FirebaseStorage storage =
//         firebase_storage.FirebaseStorage.instance;
//     final Directory appDirectory = await getApplicationDocumentsDirectory();
//     final String filePath = '${appDirectory.path}/${url.split('/').last}';
//     await storage.ref(url).writeToFile(File(filePath));
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('PDF downloaded successfully')),
//     );
//   }

  List<String> notesList = [
    'Note 1',
    'Note 2',
    'Note 3',
    'Note 1',
    'Note 2',
    'Note 3',
    'Note 1',
    'Note 2',
    'Note 3',
    'Note 1',
    'Note 2',
    'Note 3',
    'Note 1',
    'Note 2',
    'Note 3',
    'Note 1',
    'Note 2',
    'Note 3',
    'Note 1',
    'Note 2',
    'Note 3',
  ];

  List<String> pastPapersList = [
    'Past Paper 1',
    'Past Paper 2',
    'Past Paper 3',
    'Past Paper 1',
    'Past Paper 2',
    'Past Paper 3',
    'Past Paper 1',
    'Past Paper 2',
    'Past Paper 3',
    'Past Paper 1',
    'Past Paper 2',
    'Past Paper 3',
    'Past Paper 1',
    'Past Paper 2',
    'Past Paper 3',
    'Past Paper 1',
    'Past Paper 2',
    'Past Paper 3',
  ];

  List<String> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = notesList; // Initially display notes
  }

  void filterFiles(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        // If search text is empty, display all files
        filteredList = notesList;
        return;
      }

      // Filter files based on search text
      filteredList = notesList
          .where(
              (note) => note.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void navigateToSearchPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(filteredList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add your action code here
            },
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 0, left: 5, right: 5),
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                widget.title,
                style: GoogleFonts.mavenPro(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 180,
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Align evenly
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(
                          () {
                            filteredList = notesList;
                          },
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.orange,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 15),
                              child: const Icon(
                                Icons.book_sharp,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Notes',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    Text(
                                      'Modules',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: Colors.orange,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(
                          () {
                            filteredList = pastPapersList;
                          },
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.deepPurpleAccent,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 15),
                              child: const Icon(
                                Icons.book_sharp,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pastpaper',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    Text(
                                      'Modules',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                'List of Modules',
                style: GoogleFonts.mavenPro(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: backround,
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10, left: 5),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: backround,
                                image: const DecorationImage(
                                  image: AssetImage(
                                    'assets/images/logo/manas.jpg',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(filteredList[index]),
                                    const Text(
                                      '1st Year 1st Semester',
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.download),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  final List<String> searchList;

  const SearchPage(this.searchList);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = widget.searchList;
  }

  void filterSearchList(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredList = widget.searchList;
        return;
      }

      filteredList = widget.searchList
          .where(
              (item) => item.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: filterSearchList,
          decoration: const InputDecoration(
            hintText: 'Search',
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(filteredList[index]),
          );
        },
      ),
    );
  }
}
