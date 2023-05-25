import 'package:flutter/material.dart';

class search_page extends StatefulWidget {
  const search_page({super.key});

  @override
  State<search_page> createState() => _search_pageState();
}

class _search_pageState extends State<search_page> {
  static List<NotesModel> notes_list = [
    NotesModel("HNDIT", "Data Structure", 2),
    NotesModel("HNDIT", "OOPS", 2),
    NotesModel("HNDIT", "Data Communication and Network", 2)
  ];

  List<NotesModel> display_list = List.from(notes_list);

  void updateList(String value) {
    setState(() {
      display_list = notes_list.where((element) => element.sub_title!.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search for a Notes",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => updateList(value),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
                hintText: "eg: Data Structure",
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.black12,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: display_list.length == 0 ? Center(child: Text("No Results Found", style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),),): ListView.builder(
              itemCount: display_list.length,
              itemBuilder: (context, index) => ListTile(
                contentPadding: EdgeInsets.all(8),
                title: Text(display_list[index].sub_title!,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                ),
                subtitle: Text(
                  '${display_list[index].department!}',style: TextStyle(
                  color: Colors.black26,
                  fontWeight: FontWeight.bold,
                ),
                ),
                trailing: Text(
                  '${display_list[index].year!}',style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                ),
             //   leading: Image.network(display_list[index].sub_image!),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class NotesModel {
  String? sub_title;
  String? department;
  int? year;
  //String? sub_image;

  NotesModel(this.department, this.sub_title, this.year);
}