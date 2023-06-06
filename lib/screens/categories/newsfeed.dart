import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/screens/categories/newsfeed_view.dart';

class newsfeed extends StatefulWidget {
  const newsfeed({Key? key}) : super(key: key);

  @override
  State<newsfeed> createState() => _newsfeedState();
}

class _newsfeedState extends State<newsfeed> {
  List<bool> isPressedList = List.generate(15, (index) => false);
  int selectedCardIndex = 0;

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
              padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 10),
              child: SizedBox(
                child: Text(
                  'Latest News',
                  style: GoogleFonts.mavenPro(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const newsfeed_view()),
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
                                  'Manas Afrid',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: const Text(
                                  '12 min ago',
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
                                      height: 200,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          'assets/images/logo/manas.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Center(
                                        child: Text(
                                          'The Academic week schedule moved to another two weeks'
                                              .split('/')
                                              .last
                                              .trimLeft(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
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
}
