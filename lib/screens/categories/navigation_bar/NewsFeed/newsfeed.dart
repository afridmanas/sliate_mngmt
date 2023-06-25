import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/screens/categories/navigation_bar/NewsFeed/newsfeed_view.dart';
import 'package:sliate/screens/categories/navigation_bar/NewsFeed/newsfeed_add.dart';
import 'package:sliate/screens/error_page.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  List<bool> isPressedList = [];
  bool isLoading = true;
  String errorMessage = '';
  Timer? autoRefreshTimer;

  @override
  void initState() {
    super.initState();
    loadNewsFeed();
    startAutoRefresh();
  }

  @override
  void dispose() {
    autoRefreshTimer?.cancel(); // Cancel the timer on dispose
    super.dispose();
  }

  Future<void> loadNewsFeed() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('news_feed').get();

      setState(() {
        isPressedList = List.generate(snapshot.docs.length, (index) => false);
        isLoading = false;
        errorMessage = '';
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load news feed.';
      });
      ErrorHandling.navigateToErrorScreen();
    }
  }

  void startAutoRefresh() {
    autoRefreshTimer =
        Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (mounted && !isLoading) {
        loadNewsFeed();
      }
    });
  }

  Future<void> _refreshNewsFeed() async {
    if (!isLoading) {
      await loadNewsFeed();
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
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 10),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'News Feed',
                      style: GoogleFonts.mavenPro(
                        textStyle: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : errorMessage.isNotEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              errorMessage,
                              style: const TextStyle(fontSize: 18.0),
                            ),
                            ElevatedButton(
                              onPressed: _refreshNewsFeed,
                              child: const Text('Retry'),
                            ),
                          ],
                        )
                      : RefreshIndicator(
                          onRefresh: _refreshNewsFeed,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('news_feed')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              List<DocumentSnapshot> newsList =
                                  snapshot.data!.docs;

                              return ListView.builder(
                                itemCount: newsList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String newsTitle =
                                      newsList[index].get('title') ?? '';
                                  String newsDescription =
                                      newsList[index].get('description') ?? '';
                                  String newsDate =
                                      newsList[index].get('date') ?? '';
                                  String newsBanner =
                                      newsList[index].get('banner_image') ?? '';

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => newsfeed_view(
                                            description: newsDescription,
                                            imageUrl: newsBanner,
                                            title: newsTitle,
                                            date: newsDate,
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
                                        padding:
                                            const EdgeInsets.only(bottom: 15.0),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
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
                                                  'ATI- Sammanthurai',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  newsDate,
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                trailing: IconButton(
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: isPressedList
                                                                    .length >
                                                                index &&
                                                            isPressedList[index]
                                                        ? Colors.red
                                                        : Colors.grey,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (isPressedList.length >
                                                          index) {
                                                        isPressedList[index] =
                                                            !isPressedList[
                                                                index];
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 150,
                                                      width: double.infinity,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Image.network(
                                                          newsBanner,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Center(
                                                        child: Text(
                                                          newsTitle,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
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
