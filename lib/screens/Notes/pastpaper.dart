import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sliate/color.dart';

class PassPaperList extends StatefulWidget {
  const PassPaperList({super.key});

  @override
  _PassPaperListState createState() => _PassPaperListState();
}

class _PassPaperListState extends State<PassPaperList> {
  late Stream<List<File>> _downloadStream;

  Directory getTemporaryDirectorySync() {
    return Directory.systemTemp;
  }

  @override
  void initState() {
    super.initState();
    _downloadStream = FirebaseStorage.instance
        .ref()
        .child('/HNDIT/1st Year/1st Semester/Structure Programming')
        .listAll()
        .asStream()
        .asyncMap((result) async {
      final files = <File>[];
      for (final ref in result.items) {
        final file = File('${(getTemporaryDirectorySync()).path}/${ref.name}');
        final response = await ref.getDownloadURL();
        final http.Response fileResponse = await http.get(Uri.parse(response));
        await file.writeAsBytes(fileResponse.bodyBytes);
        files.add(file);
      }
      return files;
    });
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
            icon: const Icon(Icons.home),
            onPressed: () {
              // Add your action code here
            },
          ),
        ],
      ),
      body: StreamBuilder<List<File>>(
        stream: _downloadStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!;
            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: widget_clr1,
                    ),
                    child: ListTile(
                      title: Text(file.path.split('/').last.trimLeft()),
                      trailing: const Icon(Icons.file_download),
                      subtitle: const Text('1st Year 1st Semester'),
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: widget_clr2,
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/logo/manas.jpg',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      onTap: () async {
                        final directory =
                            await getApplicationDocumentsDirectory();
                        final path =
                            '${directory.path}/${file.path.split('/').last}';
                        await file.copy(path);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('File downloaded successfully'),
                        ));
                      },
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
