import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class WebScrapingPage extends StatefulWidget {
  const WebScrapingPage({Key? key}) : super(key: key);

  @override
  _WebScrapingPageState createState() => _WebScrapingPageState();
}

class _WebScrapingPageState extends State<WebScrapingPage> {
  String _data = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://www.sliate.ac.lk/'));

    if (response.statusCode == 200) {
      final document = parser.parse(response.body);
      var responseString1 = document
          .getElementsByClassName('sp-column ')[0]
          .children[0]
          .children[0];

      print(responseString1.text
          .trim()); // Replace with the actual HTML element ID you want to scrape

      if (document != null) {
        setState(() {
          _data = responseString1.text;
        });
      }
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web Scraping Example'),
      ),
      body: Center(
        child: Text(_data),
      ),
    );
  }
}
