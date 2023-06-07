import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/screens/navigation_bar/NewsFeed/newsfeed_view.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class newsfeed extends StatefulWidget {
  const newsfeed({Key? key}) : super(key: key);

  @override
  State<newsfeed> createState() => _newsfeedState();
}

class Article {
  final String title;
  final String description;
  final String urlToImage;
  final String published;
  // Add other properties you want to extract from the news API response

  Article(
      {required this.published,
      required this.urlToImage,
      required this.title,
      required this.description});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'],
      published: json['publishedAt'],

      // Initialize other properties from the JSON response
    );
  }
}

class _newsfeedState extends State<newsfeed> {
  List<Article> _articles = [];
  List<bool> isPressedList = List.generate(15, (index) => false);
  int selectedCardIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<List<Article>> fetchNews() async {
    final apiKey = 'ec3684ce79254dfcb0dbd0889ea4d448';
    final apiUrl =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Article> articles = (jsonData['articles'] as List)
          .map((data) => Article.fromJson(data))
          .toList();
      return articles;
    } else {
      throw Exception('Failed to fetch news');
    }
  }

  Future<void> _fetchNews() async {
    try {
      List<Article> fetchedArticles = await fetchNews();
      setState(() {
        _articles = fetchedArticles;
      });
    } catch (error) {
      print('Error fetching news: $error');
      // Handle the error appropriately in your app
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 08.0, right: 8, bottom: 10),
              child: SizedBox(
                child: Text(
                  'News Feed',
                  style: GoogleFonts.mavenPro(
                    textStyle: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .5),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (BuildContext context, int index) {
                  final article = _articles[index];
                  final String timeAgo = formatTimeAgo(article.published);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => newsfeed_view(
                            description: article.description,
                            urlToImage: article.urlToImage,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 3,
                          child: Column(
                            children: [
                              ListTile(
                                leading: const CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'assets/images/logo/manas.jpg',
                                  ),
                                ),
                                title: const Text(
                                  'ATI-Sammanthurai',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  timeAgo,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: isPressedList[index]
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPressedList[index] =
                                          !isPressedList[index];
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 150,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(
                                          article.urlToImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Center(
                                        child: Text(
                                          article.title
                                              .split('/')
                                              .last
                                              .trimLeft(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String extractTime(String publishedAt) {
    DateTime dateTime = DateTime.parse(publishedAt);
    String time =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    return time;
  }

  String formatTimeAgo(String publishedAt) {
    DateTime dateTime = DateTime.parse(publishedAt);
    Duration timeAgo = DateTime.now().difference(dateTime);

    if (timeAgo.inDays > 0) {
      return '${timeAgo.inDays} ${timeAgo.inDays > 1 ? 'days' : 'day'} ago';
    } else if (timeAgo.inHours > 0) {
      return '${timeAgo.inHours} ${timeAgo.inHours > 1 ? 'hours' : 'hour'} ago';
    } else if (timeAgo.inMinutes > 0) {
      return '${timeAgo.inMinutes} ${timeAgo.inMinutes > 1 ? 'minutes' : 'minute'} ago';
    } else {
      return 'Just now';
    }
  }
}
