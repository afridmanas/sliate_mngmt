import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class PDFDownloader extends StatefulWidget {
  @override
  _PDFDownloaderState createState() => _PDFDownloaderState();
}

class _PDFDownloaderState extends State<PDFDownloader> {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  List<String> pdfUrls = [];
  Map<String, double> downloadProgress = {};

  @override
  void initState() {
    super.initState();
    fetchPDFFiles();
  }

  Future<void> fetchPDFFiles() async {
    final firebase_storage.ListResult result = await storage
        .ref()
        .child('Academic Modules/HNDIT/Semester 1/Web Development/Notes')
        .listAll();

    setState(() {
      pdfUrls = result.items.map((firebase_storage.Reference ref) {
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
      _showSnackBar(filePath);
    } else {
      print('Download failed');
    }
  }

  void _showSnackBar(String filePath) {
    final snackBar = SnackBar(
      content: Text('PDF downloaded'),
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
      appBar: AppBar(
        title: Text('PDF Downloader'),
      ),
      body: pdfUrls.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: pdfUrls.length,
              itemBuilder: (context, index) {
                final pdfUrl = pdfUrls[index];
                final fileName = pdfUrl.split('/').last;
                 final progress = downloadProgress[pdfUrl] ?? 0;
                return ListTile(
                  title: Text(fileName),
                  subtitle: progress > 0
                      ? LinearProgressIndicator(
                          value: progress / 100,
                        )
                      : null,
                  onTap: () {
                    _startDownload(pdfUrl);
                  },
                );
              },
            ),
    );
  }
}
