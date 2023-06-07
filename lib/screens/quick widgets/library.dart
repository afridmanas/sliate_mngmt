import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  List Books = [
    'Structure Programming',
    'Data Structure and Algorithm',
    'Structure Programming',
    'Data Structure and Algorithm',
    'Structure Programming',
    'Data Structure and Algorithm',
    'Structure Programming',
    'Data Structure and Algorithm',
    'Structure Programming',
    'Data Structure and Algorithm',
    'Structure Programming',
    'Data Structure and Algorithm',
    'Structure Programming',
    'Data Structure and Algorithm',
    'Structure Programming',
    'Data Structure and Algorithm',
  ];
  String searchText = '';

  void onSearchTextChanged(String value) {
    setState(() {
      searchText = value;
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
          color: Colors.black, // Change the color of the back arrow here
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
        ),
        child: Container(
          child: Column(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Library',
                      style: GoogleFonts.mavenPro(
                        textStyle: const TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .5),
                      ),
                    ),
                    Text(
                      'Find your favourite book',
                      style: GoogleFonts.mavenPro(
                        textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            letterSpacing: .5),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  child: TextField(
                    onChanged: onSearchTextChanged,
                    decoration: InputDecoration(
                      hintText: 'Search for book',
                      suffixIcon: const Icon(LineIcons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 140,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Catogeries'), Text('See All')],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, Index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.red,
                              ),
                              width: 100,
                              child: Center(
                                child: Text('Box'),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Available Books'),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: Books.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      leading: Icon(LineIcons.book),
                      title: Text(Books[index]),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
