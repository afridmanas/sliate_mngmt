import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:sliate/screens/Notes/downloaded_files.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sliate/color.dart';

class NotesPatPaper extends StatefulWidget {
  final String title;
  final String notes_path;
  final String past_path;

  const NotesPatPaper(
      {Key? key,
      required this.title,
      required this.notes_path,
      required this.past_path})
      : super(key: key);

  @override
  _NotesPatPaperState createState() => _NotesPatPaperState();
}

class _NotesPatPaperState extends State<NotesPatPaper> {
  List<String> filteredList = [];
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  List<String> Notes_list = [];
  List<String> pastpaper_list = [];
  Map<String, double> downloadProgress = {};
  Map<String, bool> isDownloaded = {};

  @override
  void initState() {
    super.initState();
    fetchPDFFiles();
    initializeDownloadedStatus();
  }

  void initializeDownloadedStatus() {
    for (final pdfUrl in Notes_list + pastpaper_list) {
      isDownloaded[pdfUrl] = false;
    }
  }

  Future<void> fetchPDFFiles() async {
    final firebase_storage.ListResult notes_results =
        await storage.ref(widget.notes_path).listAll();
    final firebase_storage.ListResult past_results =
        await storage.ref(widget.past_path).listAll();
    setState(() {
      Notes_list = notes_results.items.map((firebase_storage.Reference ref) {
        return ref.fullPath;
      }).toList();
      pastpaper_list = past_results.items.map((firebase_storage.Reference ref) {
        return ref.fullPath;
      }).toList();
    });
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String?> _downloadPDF(String url, String fileName) async {
    final path = await _localPath;
    final file = File('$path/$fileName');

    try {
      final firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref(url);
      final firebase_storage.DownloadTask downloadTask = ref.writeToFile(file);

      downloadTask.snapshotEvents.listen(
        (firebase_storage.TaskSnapshot snapshot) {
          final progress =
              (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          setState(() {
            downloadProgress[url] = progress;
          });
        },
        onError: (error) {
          print('Download error: $error');
        },
        onDone: () {
          setState(() {
            downloadProgress.remove(url);
          });
          print('Download complete');
        },
      );

      await downloadTask;
    } catch (e) {
      print('Error downloading file: $e');
      return null;
    }

    return file.path;
  }

  void _startDownload(String pdfUrl) async {
    final fileName = pdfUrl.split('/').last;
    final filePath = await _downloadPDF(pdfUrl, fileName);

    if (filePath != null) {
      print('PDF downloaded to: $filePath');
      setState(() {
        isDownloaded[pdfUrl] = true;
      });

      _showSnackBar(filePath);
    } else {
      print('Download failed');
    }
  }

  void _showSnackBar(String filePath) {
    final snackBar = SnackBar(
      content: const Text('PDF downloaded'),
      action: SnackBarAction(
        label: 'Open',
        onPressed: () {
          _launchURL(filePath);
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _launchURL(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      final directory = await getExternalStorageDirectory();
      final fileName = filePath.split('/').last;
      final newPath = '${directory!.path}/$fileName';
      await file.copy(newPath);
      await OpenFile.open(newPath);
    } else {
      print('File does not exist: $filePath');
    }
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
            icon: const Icon(Icons.folder),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => DownloadedFilesList()),
                ),
              );
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
                            filteredList = Notes_list;
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
                            filteredList = pastpaper_list;
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
                child: filteredList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final pdfUrl = filteredList[index];
                          final fileName = pdfUrl.split('/').last;
                          final progress = downloadProgress[pdfUrl] ?? 0;
                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: bg_clr,
                            ),
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        right: 10, left: 5),
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: bg_clr,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fileName,
                                            style: TextStyle(
                                              color: text_clr,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Text(
                                            '1st Year 1st Semester',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if ((isDownloaded[pdfUrl] ?? false) ==
                                              false &&
                                          progress <= 0.0) {
                                        _startDownload(pdfUrl);
                                      }
                                    },
                                    icon: (isDownloaded[pdfUrl] ?? false)
                                        ? Icon(Icons.done)
                                        : progress > 0.0
                                            ? SpinKitCircle(
                                                color: Colors.blue,
                                                size: 20.0,
                                              )
                                            : Icon(Icons.download),
                                  ),
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
              (note) => note.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterSearchList,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredList[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
