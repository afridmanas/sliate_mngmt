import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class DownloadedFilesList extends StatefulWidget {
  @override
  _DownloadedFilesListState createState() => _DownloadedFilesListState();
}

class _DownloadedFilesListState extends State<DownloadedFilesList> {
  List<FileSystemEntity> downloadedFiles = [];

  @override
  void initState() {
    super.initState();
    listDownloadedFiles();
  }

  Future<void> listDownloadedFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = Directory(directory.path).listSync();

    files
        .sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));

    setState(() {
      downloadedFiles = files;
    });
  }

  Future<void> _launchURL(String filePath) async {
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
        title: Text('Downloaded Files'),
      ),
      body: ListView.builder(
        itemCount: downloadedFiles.length,
        itemBuilder: (context, index) {
          final file = downloadedFiles[index];
          final fileName = file.path.split('/').last;

          return ListTile(
            title: Text(
              fileName,
            ),
            leading: Icon(Icons.note_rounded),
            onTap: () => _launchURL(file.path),
          );
        },
      ),
    );
  }
}
